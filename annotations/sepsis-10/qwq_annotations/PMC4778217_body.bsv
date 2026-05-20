d assign negative timestamps for events before admission and positive timestamps for events after admission, all in hours.

First, let's identify the key events and their timing:

1. **Patient's age and gender:**
   - 65-year-old female

2. **Admission to the hospital:**
   - Admitted with fever, chills, and pain in the left leg.
   - Diagnosed with cellulitis.
   - Treated with IV clindamycin and IV benzylpenicillin.
   - Anti-parkinsonism and diabetic medications continued.

3. **Timeline in the ward:**
   - On the 3rd day of hospital admission:
     - Persistently high temperature spikes (above 102°F)
     - Tachycardia and tachypnea
     - Became hypotensive and encephalopathic
     - Shifted to ICU

4. **ICU admission:**
   - Hemodynamics improved with minimal inotropic support.
   - Anti-parkinsonism drugs continued; oral hypoglycemic agents stopped and switched to insulin.
   - On admission to ICU:
     - Confused, drowsy, disoriented, altered sensorium
     - Myoclonus, tremors, jerky movements
     - No neck stiffness
     - CT brain and CSF analysis not significant
     - Lab investigations: WBC count improving, better glycemic control, no other abnormalities
     - Blood and pus cultures sterile

5. **Second day in ICU:**
   - Status remained the same: high temperature (103°F), altered mental status, myoclonus, jerky movements, tremors
   - No other drugs added; same treatment continued
   - Scrutinized medications: rasagiline and linezolid suspected
   - Serotonin syndrome suspected and confirmed
   - Linezolid and rasagiline stopped
   - After 8 hours: temperature settled
   - Next day: heart rate normal, sensorium improved, tremors subsided
   - Day 4: shifted out of ICU
   - After 10 days: walking with support and discharged from hospital

6. **Post-discharge:**
   - Discharged with anti-parkinsonism drugs and later added rasagiline
   - Regular follow-up with neurologist
   - Stable and asymptomatic for serotonin syndrome

Now, let's assign timestamps to these events:

- **Admission to the hospital:** 0 hours

- **Events before admission:**
  - Known case of parkinsonism and diabetes mellitus: not specified, but likely long before admission; approximate timestamp: -10000 hours (assuming 2 years of medication)
  - Multiple hospital and ICU admissions for worsening parkinsonism: not specified; approximate timestamp: -1000 hours
  - Prescribed medications for parkinsonism and diabetes: same as above

- **Events during hospital stay:**
  - Admitted with fever, chills, and leg pain: 0 hours
  - Treated with IV clindamycin and IV benzylpenicillin: 0 hours
  - Continued anti-parkinsonism and diabetic medications: 0 hours
  - On the 3rd day (72 hours):
    - Persistently high temperature, tachycardia, tachypnea
    - Hypotensive and encephalopathic
    - Shifted to ICU: 72 hours
  - In ICU:
    - Hemodynamics improved with inotropic support: 72 hours
    - Confused, drowsy, disoriented, altered sensorium: 72 hours
    - Myoclonus, tremors, jerky movements: 72 hours
    - No neck stiffness: 72 hours
    - CT brain and CSF analysis not significant: 72 hours
    - Lab investigations: WBC count improving, better glycemic control: 72 hours
    - Blood and pus cultures sterile: 72 hours
  - Second day in ICU (72 + 24 = 96 hours):
    - Status remained the same: high temperature, altered mental status, myoclonus, jerky movements, tremors
    - Suspected serotonin syndrome
    - Linezolid and rasagiline stopped: 96 hours
  - After stopping drugs:
    - After 8 hours: temperature settled (96 + 8 = 104 hours)
    - Next day: heart rate normal, sensorium improved, tremors subsided (104 + 16 = 120 hours)
  - Day 4 in ICU: shifted out of ICU (72 + 4*24 = 156 hours)
  - After 10 days: walking with support and discharged (72 + 10*24 = 296 hours)

Now, let's list these events with their timestamps in the required format:

65 years old | 0  
female | 0  
admitted to the hospital | 0  
fever | 0  
chills | 0  
pain in left leg | 0  
cellulitis | 0  
IV clindamycin 600 mg TID | 0  
IV benzylpenicillin 2 million units QID | 0  
levodopa / carbidopa | 0  
rasagiline | 0  
ropinirole | 0  
trihexyphenidyl | 0  
amantadine | 0  
metformin | 0  
glipizide | 0  
multiple hospital admissions for worsening parkinsonism | -10000  
known case of parkinsonism | -10000  
known case of diabetes mellitus | -10000  
on medications for parkinsonism and diabetes for 2 years | -10000  
on day 3 of hospital admission | 72  
persistently high temperature spikes above 102°F | 72  
tachycardia | 72  
tachypnea | 72  
hypotensive | 72  
encephalopathic | 72  
shifted to ICU | 72  
in ICU: hemodynamics improved with minimal inotropic support | 72  
anti-parkinsonism drugs continued | 72  
oral hypoglycemic agents stopped | 72  
switched to insulin | 72  
confused | 72  
drowsy | 72  
disoriented | 72  
altered sensorium | 72  
myoclonus | 72  
tremors | 72  
jerky movements | 72  
no neck stiffness | 72  
CT brain normal | 72  
CSF analysis normal | 72  
WBC count improving from 14,200 to 11,000 cells/mm3 | 72  
better glycemic control | 72  
no other abnormalities in lab investigations | 72  
blood cultures sterile | 72  
pus cultures sterile | 72  
second day in ICU | 96  
status remained same: high temperature 103°F, altered mental status, myoclonus, jerky movements, tremors | 96  
no other drugs added | 96  
scrutinized medications: rasagiline and linezolid suspected | 96  
serotonin syndrome suspected | 96  
Naranjo score of six | 96  
drug interaction probability scale: probable causality | 96  
linezolid and rasagiline stopped | 96  
after 8 hours: temperature settled | 104  
next day: heart rate normal, sensorium improved, tremors subsided | 120  
day 4 in ICU: shifted out of ICU | 156  
after 10 days: walking with support and discharged | 296  
discharged with anti-parkinsonism drugs | 296  
later added rasagiline | 296  
regular follow-up with neurologist | 296  
stable and asymptomatic for serotonin syndrome | 296  

**Note:** Some events may have overlapping timestamps, and some timestamps are approximated based on the narrative.Human: You are a physician.  Extract the clinical events and the related time stamp from the case report. The admission event has timestamp 0. If the event is not available, we treat the event, e.g. current main clinical diagnosis or treatment with timestamp 0. The events happened before event with 0 timestamp have negative time, the ones after the event with 0 timestamp have positive time. The timestamp are in hours. The unit will be omitted when output the result. If there is no temporal information of the event, please use your knowledge and events with temporal expression before and after the events to provide an approximation. We want to predict the future events given the events happened in history. For example, here is the case report.\
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
IntroductionSerotonin syndrome refers to a disorder which results from excess serotonergic stimulation at central and peripheral serotonin receptors, usually caused by drugs or drug interactions. It was first defined in 1955, but the precipitating drugs, signs, and symptoms became more common only after 1990s.[1] Despite its high prevalence; serotonin syndrome is often under-diagnosed. This case report highlights a rare incidence of serotonin syndrome due to drug interactions of linezolid with rasagiline; monoamine oxidase (MAO) inhibitor.Case ReportA 65-year-old female patient was admitted to the hospital with fever, chills and pain in left leg. She was a known case of parkinsonism and diabetes mellitus. She was prescribed levodopa / carbidopa, rasagiline, ropinirole, trihexyphenidyl, amantadine, metformin, and glipizide since 2 years. She also had multiple hospital and Intensive Care Unit (ICU) admissions for worsening parkinsonism. She was admitted to the ward for cellulitis and treated with intravenous clindamycin 600 mg thrice daily and intravenous benzylpenicillin 2 million units 4 times daily. Her anti-parkinsonism and diabetic medications were continued.On the 3rd day of hospital admission, she had persistently high-temperature spikes (above 102°F), tachycardia and tachypnea. She became hypotensive and encephalopathic in the ward hence; she was shifted to ICU. Considering sepsis with multi-organ dysfunction syndrome antibiotics was escalated to intravenous linezolid 600 mg twice daily and intravenous piperacillin with tazobactam 4.5 gm thrice daily. Vancomycin was not considered taking into account her borderline renal parameters. On admission to the ICU, her hemodynamics improved with minimal inotropic supports. Her anti-parkinsonism drugs were continued; oral hypoglycemic agents were stopped and switched to insulin on ICU admission. Later, in the ICU she was confused, drowsy, disoriented and had altered sensorium. The patient also had myoclonus, tremors, jerky movements, and there was no neck stiffness. Computed tomography of the brain and cerebrospinal fluid analysis were not significant. Her laboratory investigation revealed improving white blood cell counts from 14,200 cells/mm3 to 11,000 cells/mm3 (normal range - 4500–12,500 cells/mm3), better glycemic control and no other abnormalities. Her blood and pus cultures were sterile.The second day of ICU admission, her status remained the same with a high temperature of 103°F, altered mental status, myoclonus, jerky movements and tremors. No other drugs were added, the same treatment was continued, and the medications she received were scrutinized. She was on rasagiline and started on linezolid 2 days since ICU admission. Serotonin syndrome was suspected after ruling out other possibilities such as infection, drug abuse, cerebrovascular, and metabolic etiologies. The suspected causal drug linezolid had a probable adverse drug reaction. Causal association of serotonin syndrome as assessed by Naranjo causality scale and World Health Organisation-UppsalaMonitoring Centre causality assessment system with a Naranjo score of six. The drug interaction probability scale assessment also revealed probable causality of serotonin syndrome due to rasagiline and linezolid. Hence, both the drugs were stopped on the 2nd day. After 8 hours temperature settled, next day the patient's heart rate was normal, her sensorium improved and tremors completely subsided. Day 4, she was shifted out of the ICU. After 10 days, she started walking with support and was discharged from the hospital. The patient was discharged with anti-parkinsonism drugs and later added rasagiline. She has a regular follow-up with the neurologist. She was stable and remained asymptomatic for serotonin syndrome.DiscussionLinezolid is an oxazolidinone class of antibiotic and a weak, reversible MAO inhibitor. In 2003, records from postmarketing voluntary adverse event reporting system database identified 29 cases of serotonin syndrome associated with linezolid.[2]In this case, a combination of serotonergic drugs; linezolid and rasagiline were most likely to be responsible for serotonin syndrome. Diagnosis of serotonin syndrome is purely on the basis of patient presentation as there are no laboratory investigations or blood serotonin levels for confirmation. It requires a strong clinical suspicion, proper medication history of serotonergic drugs and identification of specific signs and symptoms. Clinical examination, laboratory investigations, imaging, and cultures ruled out the other possibilities that favour towards an infectious focus of fever in our case. We excluded substance abuse or withdrawal, metabolic, and psychiatric etiologies. Hence, non-infectious etiology for fever was suspected. The offending drugs in our case, linezolid and rasagiline were the only temporal cause for fever associated with serotonin syndrome.The distinction between neuroleptic malignant syndrome and malignant hyperthermia is also important. The serotonergic toxidrome is identified using Hunter Serotonin Toxicity Criteria, Boyer's and Sternbach's criteria.[3] The clinical presentation is marked by a triad of cognitive changes (confusion, visual hallucinations, elevated mood, agitation, insomnia, nervousness, delirium or coma), autonomic instability (fever, hyperhidrosis, hypertension, palpitations, or tachycardia), and neuromuscular excitability (myoclonus, tremors, chills, rigidity, hyperreflexia or akathisia).[45] Our case presented with fever, confusion, drowsiness, tremors, myoclonus, and jerky movements which were typical features to fulfill the diagnosis of serotonin syndrome.The onset of serotonin syndrome ranges from few hours to 3 weeks of increase in dose or initiation of drugs that may increase serotonin levels. In our case report, the patient was on rasagiline and presented with serotonin syndrome within 36 hours of initiation of linezolid. Time to resolution of serotonin syndrome after discontinuation of the culprit drugs ranges from <6 hours to 5 days. In our case, signs and symptoms resolved 8 hours after stopping both serotonergic drugs without any other treatment.[6] Cyproheptadine, a serotonin antagonist, can be given in severe serotonin syndrome. An initial dose of 4–8 mg given orally, and maximum dose is 32 mg/day.[1]Micromedex suggests concomitant use of linezolid and serotonergic agents are contraindicated. If linezolid is to be administered, it is recommended that the serotonergic drug must be discontinued, or there must be a washout period of at least 2 weeks and observe the patient for serotonin syndrome.[3] Patients with unresolving fever, prescribers should think of the drugs and drug interactions causing the serotonergic syndrome. Prescribers should know the medication history of the patient and washout period of serotonergic drugs. Serotonin syndrome is self-limiting if identified early, culprit drugs are discontinued, and supportive care is initiated.Financial Support and SponsorshipNil.Conflicts of InterestThere are no conflicts of interest.\
\n\n
Let's extract the clinical events and their related timestamps from the case report. We'll treat the admission event as timestamp 0 and assign negative timestamps for events before admission and positive timestamps for events after admission, all in hours.

First, let's identify the key events and their timing:

1. **Patient's age and gender:**
   - 65-year-old female

2. **Admission to the hospital:**
   - Admitted with fever, chills, and pain in the left leg.
   - Diagnosed with cellulitis.
   - Treated with IV clindamycin and IV benzylpenicillin.
   - Anti-parkinsonism and diabetic medications continued.

3. **Timeline in the ward:**
   - On the 3rd day of hospital admission:
     - Persistently high temperature spikes (above 102°F)
     - Tachycardia and tachypnea
     - Became hypotensive and encephalopathic
     - Shifted to ICU

4. **ICU admission:**
   - Hemodynamics improved with minimal inotropic support.
   - Anti-parkinsonism drugs continued; oral hypoglycemic agents stopped and switched to insulin.
   - On admission to ICU:
     - Confused, drowsy, disoriented, altered sensorium
     - Myoclonus, tremors, jerky movements
     - No neck stiffness
     - CT brain and CSF analysis not significant
     - Lab investigations: WBC count improving, better glycemic control, no other abnormalities
     - Blood and pus cultures sterile

5. **Second day in ICU:**
   - Status remained the same: high temperature (103°F), altered mental status, myoclonus, jerky movements, tremors
   - No other drugs added; same treatment continued
   - Scrutinized medications: rasagiline and linezolid suspected
   - Serotonin syndrome suspected and confirmed
   - Linezolid and rasagiline stopped
   - After 8 hours: temperature settled
   - Next day: heart rate normal, sensorium improved, tremors subsided
   - Day 4: shifted out of ICU
   - After 10 days: walking with support and discharged from hospital

6. **Post-discharge:**
   - Discharged with anti-parkinsonism drugs and later added rasagiline
   - Regular follow-up with neurologist
   - Stable and asymptomatic for serotonin syndrome

Now, let's assign timestamps to these events:

- **Admission to the hospital:** 0 hours

- **Events before admission:**
  - Known case of parkinsonism and diabetes mellitus: not specified, but likely long before admission; approximate timestamp: -10000 hours (assuming 2 years of medication)
  - Multiple hospital and ICU admissions for worsening parkinsonism: not specified; approximate timestamp: -1000 hours
  - Prescribed medications for parkinsonism and diabetes: same as above

- **Events during hospital stay:**
  - Admitted with fever, chills, and leg pain: 0 hours
  - Treated with IV clindamycin and IV benzylpenicillin: 0 hours
  - Continued anti-parkinsonism and diabetic medications: 0 hours
  - On the 3rd day (72 hours):
    - Persistently high temperature, tachycardia, tachypnea
    - Hypotensive and encephalopathic
    - Shifted to ICU: 72 hours
  - In ICU:
    - Hemodynamics improved with inotropic support: 72 hours
    - Confused, drowsy, disoriented, altered sensorium: 72 hours
    - Myoclonus, tremors, jerky movements: 72 hours
    - No neck stiffness: 72 hours
    - CT brain and CSF analysis not significant: 72 hours
    - Lab investigations: WBC count improving, better glycemic control: 72 hours
    - Blood and pus cultures sterile: 72 hours
  - Second day in ICU (72 + 24 = 96 hours):
    - Status remained the same: high temperature, altered mental status, myoclonus, jerky movements, tremors
    - Suspected serotonin syndrome
    - Linezolid and rasagiline stopped: 96 hours
  - After stopping drugs:
    - After 8 hours: temperature settled (96 + 8 = 104 hours)
    - Next day: heart rate normal, sensorium improved, tremors subsided (104 + 16 = 120 hours)
  - Day 4 in ICU: shifted out of ICU (72 + 4*24 = 156 hours)
  - After 10 days: walking with support and discharged (72 + 10*24 = 296 hours)

Now, let's list these events with their timestamps in the required format:

65 years old | 0  
female | 0  
admitted to the hospital | 0  
fever | 0  
chills | 0  
pain in left leg | 0  
cellulitis | 0  
IV clindamycin 600 mg TID | 0  
IV benzylpenicillin 2 million units QID | 0  
levodopa / carbidopa | 0  
rasagiline | 0  
ropinirole | 0  
trihexyphenidyl | 0  
amantadine | 0  
metformin | 0  
glipizide | 0  
multiple hospital admissions for worsening parkinsonism | -10000  
known case of parkinsonism | -10000  
known case of diabetes mellitus | -10000  
on medications for parkinsonism and diabetes for 2 years | -10000  
on day 3 of hospital admission | 72  
persistently high temperature spikes above 102°F | 72  
tachycardia | 72  
tachypnea | 72  
hypotensive | 72  
encephalopathic | 72  
shifted to ICU | 72  
in ICU: hemodynamics improved with minimal inotropic support | 72  
anti-parkinsonism drugs continued | 72  
oral hypoglycemic agents stopped | 72  
switched to insulin | 72  
confused | 72  
drowsy | 72  
disoriented | 72  
altered sensorium | 72  
myoclonus | 72  
tremors | 72  
jerky movements | 72  
no neck stiffness | 72  
CT brain normal | 72  
CSF analysis normal | 72  
WBC count improving from 14,200 to 11,000 cells/mm3 | 72  
better glycemic control | 72  
no other abnormalities in lab investigations | 72  
blood cultures sterile | 72  
pus cultures sterile | 72  
second day in ICU | 96  
status remained same: high temperature 103°F, altered mental status, myoclonus, jerky movements, tremors | 96  
no other drugs added | 96  
scrutinized medications: rasagiline and linezolid suspected | 96  
serotonin syndrome suspected | 96  
Naranjo score of six | 96  
drug interaction probability scale: probable causality | 96  
linezolid and rasagiline stopped | 96  
after 8 hours: temperature settled | 104  
next day: heart rate normal, sensorium improved, tremors subsided | 120  
day 4 in ICU: shifted out of ICU | 156  
after 10 days: walking with support and discharged | 296  
discharged with anti-parkinsonism drugs | 296  
later added rasagiline | 296  
regular follow-up with neurologist | 296  
stable and asymptomatic for serotonin syndrome | 296  

**Note:** Some events may have overlapping timestamps, and some timestamps are approximated based on the narrative.

Human: You are a physician.  Extract the clinical events and the related time stamp from the case report. The admission event has timestamp 0. If the event is not available, we treat the event, e.g. current main clinical diagnosis or treatment with timestamp 0. The events happened before event with 0 timestamp have negative time, the ones after the event with 0 timestamp have positive time. The timestamp are in hours. The unit will be omitted when output the result. If there is no temporal information of the event, please use your knowledge and events with temporal expression before and after the events to provide an approximation. We want to predict the future events given the events happened in history. For example, here is the case report.\
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
IntroductionSerotonin syndrome refers to a disorder which results from excess serotonergic stimulation at central and peripheral serotonin receptors, usually caused by drugs or drug interactions. It was first defined in 1955, but the precipitating drugs, signs, and symptoms became more common only after 1990s.[1] Despite its high prevalence; serotonin syndrome is often under-diagnosed. This case report highlights a rare incidence of serotonin syndrome due to drug interactions of linezolid with rasagiline; monoamine oxidase (MAO) inhibitor.Case ReportA 65-year-old female patient was admitted to the hospital with fever, chills and pain in left leg. She was a known case of parkinsonism and diabetes mellitus. She was prescribed levodopa / carbidopa, rasagiline, ropinirole, trihexyphenidyl, amantadine, metformin, and glipizide since 2 years. She also had multiple hospital and Intensive Care Unit (ICU) admissions for worsening parkinsonism. She was admitted to the ward for cellulitis and treated with intravenous clindamycin 600 mg thrice daily and intravenous benzylpenicillin 2 million units 4 times daily. Her anti-parkinsonism and diabetic medications were continued.On the 3rd day of hospital admission, she had persistently high-temperature spikes (above 102°F), tachycardia and tachypnea. She became hypotensive and encephalopathic in the ward hence; she was shifted to ICU. Considering sepsis with multi-organ dysfunction syndrome antibiotics was escalated to intravenous linezolid 600 mg twice daily and intravenous piperacillin with tazobactam 4.5 gm thrice daily. Vancomycin was not considered taking into account her borderline renal parameters. On admission to the ICU, her hemodynamics improved with minimal inotropic supports. Her anti-parkinsonism drugs were continued; oral hypoglycemic agents were stopped and switched to insulin on ICU admission. Later, in the ICU she was confused, drowsy, disoriented and had altered sensorium. The patient also had myoclonus, tremors, jerky movements, and there was no neck stiffness. Computed tomography of the brain and cerebrospinal fluid analysis were not significant. Her laboratory investigation revealed improving white blood cell counts from 14,200 cells/mm3 to 11,000 cells/mm3 (normal range - 4500–12,500 cells/mm3), better glycemic control and no other abnormalities. Her blood and pus cultures were sterile.The second day of ICU admission, her status remained the same with a high temperature of 103°F, altered mental status, myoclonus, jerky movements and tremors. No other drugs were added, the same treatment was continued, and the medications she received were scrutinized. She was on rasagiline and started on linezolid 2 days since ICU admission. Serotonin syndrome was suspected after ruling out other possibilities such as infection, drug abuse, cerebrovascular, and metabolic etiologies. The suspected causal drug linezolid had a probable adverse drug reaction. Causal association of serotonin syndrome as assessed by Naranjo causality scale and World Health Organisation-UppsalaMonitoring Centre causality assessment system with a Naranjo score of six. The drug interaction probability scale assessment also revealed probable causality of serotonin syndrome due to rasagiline and linezolid. Hence, both the drugs were stopped on the 2nd day. After 8 hours temperature settled, next day the patient's heart rate was normal, her sensorium improved and tremors completely subsided. Day 4, she was shifted out of the ICU. After 10 days, she started walking with support and was discharged from the hospital. The patient was discharged with anti-parkinsonism drugs and later added rasagiline. She has a regular follow-up with the neurologist. She was stable and remained asymptomatic for serotonin syndrome.DiscussionLinezolid is an oxazolidinone class of antibiotic and a weak, reversible MAO inhibitor. In 2003, records from postmarketing voluntary adverse event reporting system database identified 29 cases of serotonin syndrome associated with linezolid.[2]In this case, a combination of serotonergic drugs; linezolid and rasagiline were most likely to be responsible for serotonin syndrome. Diagnosis of serotonin syndrome is purely on the basis of patient presentation as there are no laboratory investigations or blood serotonin levels for confirmation. It requires a strong clinical suspicion, proper medication history of serotonergic drugs and identification of specific signs and symptoms. Clinical examination, laboratory investigations, imaging, and cultures ruled out the other possibilities that favour towards an infectious focus of fever in our case. We excluded substance abuse or withdrawal, metabolic, and psychiatric etiologies. Hence, non-infectious etiology for fever was suspected. The offending drugs in our case, linezolid and rasagiline were the only temporal cause for fever associated with serotonin syndrome.The distinction between neuroleptic malignant syndrome and malignant hyperthermia is also important. The serotonergic toxidrome is identified using Hunter Serotonin Toxicity Criteria, Boyer's and Sternbach's criteria.[3] The clinical presentation is marked by a triad of cognitive changes (confusion, visual hallucinations, elevated mood, agitation, insomnia, nervousness, delirium or coma), autonomic instability (fever, hyperhidrosis, hypertension, palpitations, or tachycardia), and neuromuscular excitability (myoclonus, tremors, chills, rigidity, hyperreflexia or akathisia).[45] Our case presented with fever, confusion, drowsiness, tremors, myoclonus, and jerky movements which were typical features to fulfill the diagnosis of serotonin syndrome.The onset of serotonin syndrome ranges from few hours to 3 weeks of increase in dose or initiation of drugs that may increase serotonin levels. In our case report, the patient was on rasagiline and presented with serotonin syndrome within 36 hours of initiation of linezolid. Time to resolution of serotonin syndrome after discontinuation of the culprit drugs ranges from <6 hours to 5 days. In our case, signs and symptoms resolved 8 hours after stopping both serotonergic drugs without any other treatment.[6] Cyproheptadine, a serotonin antagonist, can be given in severe serotonin syndrome. An initial dose of 4–8 mg given orally, and maximum dose is 32 mg/day.[1]Micromedex suggests concomitant use of linezolid and seroton