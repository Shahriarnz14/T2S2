from transformers import AutoTokenizer, AutoModelForCausalLM
import transformers
import torch
import os
import pandas as pd

# IF(ADAPT), CHANGE: (1) model (possibly cache dir), (2) in.dir, out.dir, (3) prefix(31)/suffix(31), (4) max_new_tokens

cache_dir = "<YOUR_CACHE_DIR>"

model_name = "meta-llama/Llama-3.3-70B-Instruct"  # Modify as necessary
dtype = torch.bfloat16

txtfiles_dir = '<YOUR_INPUT_PATH_FOLDER>'
out_dir = '<YOUR_OUTPUT_PATH_FOLDER>'

model = AutoModelForCausalLM.from_pretrained(model_name,
                                            cache_dir=cache_dir,
                                            torch_dtype = dtype,
                                            device_map='auto')
tokenizer = AutoTokenizer.from_pretrained(model_name,
# tokenizer = AutoTokenizer.from_pretrained("Qwen/QwQ-32B-Preview",
# tokenizer = AutoTokenizer.from_pretrained("meta-llama/Llama-3.1-8B-Instruct",
                                          cache_dir=cache_dir)

pipeline = transformers.pipeline(
    "text-generation",
    model=model,
    torch_dtype=dtype,
    eos_token_id=tokenizer.eos_token_id,
    tokenizer=tokenizer,
    device_map="auto",
)

prefix = r'''
You are a physician.  Extract the clinical events and the related time stamp from the case report. The admission event has timestamp 0. If the event is not available, we treat the event, e.g. current main clinical diagnosis or treatment with timestamp 0. The events happened before event with 0 timestamp have negative time, the ones after the event with 0 timestamp have positive time. The timestamp are in hours. The unit will be omitted when output the result. If there is no temporal information of the event, please use your knowledge and events with temporal expression before and after the events to provide an approximation. We want to predict the future events given the events happened in history. For example, here is the case report.\
An 18-year-old male was admitted to the hospital with a 3-day history of fever and rash. Four weeks ago, he was diagnosed with acne and received the treatment with minocycline, 100 mg daily, for 3 weeks. With increased WBC count, eosinophilia, and systemic involvement, this patient was diagnosed with DRESS syndrome. The fever and rash persisted through admission, and diffuse erythematous or maculopapular eruption with pruritus was present. One day later the patient was discharged.\
Let's find the locations of event in the case report, it shows that four weeks ago of fever and rash, four weeks ago, he was diagnosed with acne and receive treatment. So the event of fever and rash happen four weeks ago, 672 hours, it is before admitted to the hospital, so the time stamp is -672. diffuse erythematous or maculopapular eruption with pruritus was documented on the admission exam, so the time stamp is 0 hours, since it happens right at admission. DRESS syndrome has no specific time, but it should happen soon after admission to the hospital, so we use our clinical judgment to give the diagnosis of DRESS syndrome the timestamp 0. then the output should look like\
18 years old| 0\
male | 0\
admitted to the hospital | 0\
fever | -72\
rash | -72\
acne |  -672\
minocycline |  -672\
increased WBC count | 0\
eosinophilia| 0\
systemic involvement| 0\
diffuse erythematous or maculopapular eruption| 0\
pruritis | 0\
DRESS syndrome | 0\
fever persisted | 0\
rash persisted | 0\
discharged | 24\
Separate conjunctive phrases into its component events and assign them the same timestamp (for example, the separation of 'fever and rash' into 2 events: 'fever' and 'rash')  If the event has duration, assign the event time as the start of the time interval. Attempt to use the text span without modifications except 'history of' where applicable. Include all patient events, even if they appear in the discussion; do not omit any events; include termination/discontinuation events; include the pertinent negative findings, like 'no shortness of breath' and 'denies chest pain'.  Show the events and timestamps in rows, each row has two columns: one column for the event, the other column for the timestamp.  The time is a numeric value in hour unit. The two columns are separated by a pipe '|' as a bar-separated file. Skip the title of the table. Place the table inside \boxed{\n TEXT HERE \n} Create the table from the following case: \n\n
''' 

prefix31 = r'''
<|begin_of_text|><|start_header_id|>system<|end_header_id|>
You are a physician.  Extract the clinical events and the related time stamp from the case report. The admission event has timestamp 0. If the event is not available, we treat the event, e.g. current main clinical diagnosis or treatment with timestamp 0. The events happened before event with 0 timestamp have negative time, the ones after the event with 0 timestamp have positive time. The timestamp are in hours. The unit will be omitted when output the result. If there is no temporal information of the event, please use your knowledge and events with temporal expression before and after the events to provide an approximation. We want to predict the future events given the events happened in history. For example, here is the case report.\
An 18-year-old male was admitted to the hospital with a 3-day history of fever and rash. Four weeks ago, he was diagnosed with acne and received the treatment with minocycline, 100 mg daily, for 3 weeks. With increased WBC count, eosinophilia, and systemic involvement, this patient was diagnosed with DRESS syndrome. The fever and rash persisted through admission, and diffuse erythematous or maculopapular eruption with pruritus was present. One day later the patient was discharged.\
Let's find the locations of event in the case report, it shows that four weeks ago of fever and rash, four weeks ago, he was diagnosed with acne and receive treatment. So the event of fever and rash happen four weeks ago, 672 hours, it is before admitted to the hospital, so the time stamp is -672. diffuse erythematous or maculopapular eruption with pruritus was documented on the admission exam, so the time stamp is 0 hours, since it happens right at admission. DRESS syndrome has no specific time, but it should happen soon after admission to the hospital, so we use our clinical judgment to give the diagnosis of DRESS syndrome the timestamp 0. then the output should look like\
18 years old| 0\
male | 0\
admitted to the hospital | 0\
fever | -72\
rash | -72\
acne |  -672\
minocycline |  -672\
increased WBC count | 0\
eosinophilia| 0\
systemic involvement| 0\
diffuse erythematous or maculopapular eruption| 0\
pruritis | 0\
DRESS syndrome | 0\
fever persisted | 0\
rash persisted | 0\
discharged | 24\
Separate conjunctive phrases into its component events and assign them the same timestamp (for example, the separation of 'fever and rash' into 2 events: 'fever' and 'rash')  If the event has duration, assign the event time as the start of the time interval. Attempt to use the text span without modifications except 'history of' where applicable. Include all patient events, even if they appear in the discussion; do not omit any events; include termination/discontinuation events; include the pertinent negative findings, like 'no shortness of breath' and 'denies chest pain'.  Show the events and timestamps in rows, each row has two columns: one column for the event, the other column for the timestamp.  The time is a numeric value in hour unit. The two columns are separated by a pipe '|' as a bar-separated file. Skip the title of the table. Reply with the table only. Create a table from the following case:
<|eot_id|><|start_header_id|>user<|end_header_id|>
'''

suffix = ''
suffix31 = r'''
<|eot_id|><|start_header_id|>assistant<|end_header_id|>
'''


# txtfiles_dir = '<YOUR_INPUT_PATH_FOLDER>'
# case_filenames = [f for f in os.listdir(txtfiles_dir) if f.endswith(".txt.gz")]
case_filenames = [f for f in os.listdir(txtfiles_dir) if f.endswith(".txt")]

# out_dir = '<YOUR_OUTPUT_PATH_FOLDER>'
if out_dir == txtfiles_dir:
    exit
os.makedirs(out_dir, exist_ok=True)

print(case_filenames) 

if True:
    for idx, case in enumerate(case_filenames):
        # if idx < 18:
        #     continue
        print(idx, "/", len(case_filenames), ": ", case)

        # Open file
        try:
            # with gzip.open(txtfiles_dir + case, 'rt') as file:  # if gzipped
            with open(txtfiles_dir + case, 'r') as file:
                case_txt = file.read().replace('\n','')
        except:
            print('exception')
            # with gzip.open(txtfiles_dir + case, 'rt', encoding='unicode_escape') as file:  # if gzipped
            with open(txtfiles_dir + case, 'r', encoding='unicode_escape') as file:
                case_txt = file.read().replace('\n','')

        # Pass query to API
        # query = prefix + case_txt + suffix  # if not a llama model
        query = prefix31 + case_txt + suffix31  # if llama model
        # try: 
        sequences = pipeline(
            query,
            do_sample=True,
            top_k=1,
            eos_token_id=tokenizer.eos_token_id,
            max_new_tokens = 8092,
        )
        for seq in sequences:
            # print(f"Result: {seq['generated_text'][len(prefix)+len(case):]}")
            stream = seq['generated_text'][len(query):]
            # stream = seq['generated_text'][len(prefix31 + case_txt + suffix31):]

        # Write to out_dir
        with open(out_dir + os.path.splitext(case)[0]+".bsv", "w") as text_file:
            text_file.write(stream)

        # Re-write as named csv (if LLM annotator is good at following formatting instructions)
        # out_names = [f for f in os.listdir(out_dir) if f.endswith(".bsv")]
        # for outname in out_names:
        try:
            df = pd.read_csv(out_dir + os.path.splitext(case)[0]+".bsv", sep="|", names = ("event","time"))
        
            df.to_csv(out_dir + os.path.splitext(case)[0]+".csv", index=False)
        except:
            print(case, "could not convert to csv")