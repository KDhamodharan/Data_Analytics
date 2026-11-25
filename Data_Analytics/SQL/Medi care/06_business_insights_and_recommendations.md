# MediCare — Dataset Findings & Management Recommendations

**Basis:** Direct aggregation of the supplied `Hospital_Analytics_DB_dataset.xlsx` workbook. These are descriptive dataset observations, not clinical-quality conclusions.

## Dataset profile
- 15 tables and 32,920 total source rows.
- 30 hospitals, 40 departments, 450 doctors, 2,000 patients, 5,100 appointments, 2,500 admissions, 3,500 treatments, 3,000 laboratory records, 2,500 pharmacy transactions, 5,000 bills and 5,000 payment transactions.

## Hospital activity

| Hospital | Appointments | Admissions | Doctors | Rooms | Occupied rooms | Occupancy % |
|---|---:|---:|---:|---:|---:|---:|
| MediCare Belagavi North Campus | 493 | 244 | 11 | 47 | 27 | 57.4% |
| MediCare Kochi North Campus | 186 | 84 | 7 | 10 | 6 | 60.0% |
| MediCare Guntur North Campus | 180 | 67 | 25 | 13 | 5 | 38.5% |
| MediCare Thiruvananthapuram Annex 2 | 174 | 75 | 11 | 17 | 6 | 35.3% |
| MediCare Coimbatore Central | 172 | 76 | 11 | 13 | 8 | 61.5% |

MediCare Belagavi North Campus has the highest appointment count (493) and admissions (244) in the supplied dataset. This is a workload observation; it should be reviewed alongside staffing, service mix and reporting completeness rather than interpreted as a quality measure.

## Department appointment workload

| Department | Appointments |
|---|---:|
| Neurology (D005) | 534 |
| Ophthalmology (D006) | 366 |
| ENT (D001) | 174 |
| Nephrology (D032) | 164 |
| Emergency Medicine (D002) | 156 |

Neurology (D005) has the highest appointment count (534), followed by Ophthalmology (D006, 366). The department mapping is based on the treating doctor's department_id because Appointments has no department_id field.

## Billing and payment collection

- Total billed amount: **₹69,675,349.98**
- Successful payment transactions: **₹61,524,505.02**
- Refunded payment transactions: **₹2,546,467.93**
- Net collected (successful less refunded): **₹58,978,037.09**
- Indicative collection gap (billed less net collected): **₹10,697,312.89**
- Indicative collection rate: **84.65%**
- Bill statuses: Paid 3,267; Partially Paid 996; Unpaid 737.
- Payment statuses: Success 4,413; Failed 390; Refunded 197.

Collection metrics aggregate payments at bill grain before joining to Billing to avoid duplicating bill totals. Finance should confirm whether refunded amounts should be subtracted in the organization's official collection-rate definition.

## Service activity observations

### Top treatment volumes
| Treatment | Count | Total treatment cost |
|---|---:|---:|
| Appendicitis Management | 213 | ₹6,454,746.17 |
| Dengue Fever Management | 193 | ₹5,793,849.76 |
| Type 2 Diabetes Mellitus Management | 193 | ₹6,011,337.27 |
| Stroke Management | 189 | ₹5,766,452.33 |
| Community Acquired Pneumonia Management | 187 | ₹5,513,009.53 |

### Top laboratory test volumes
| Test | Count | Total test cost |
|---|---:|---:|
| Ultrasound Abdomen | 204 | ₹819,076.38 |
| Liver Function Test | 193 | ₹801,558.47 |
| COVID-19 RT-PCR | 192 | ₹778,872.13 |
| HbA1c | 190 | ₹805,682.39 |
| Blood Culture | 186 | ₹783,125.36 |

### Pharmacy revenue by category
| Category | Quantity sold | Sales amount |
|---|---:|---:|
| Cardiac | 20147 | ₹6,549,505.22 |
| Vitamin & Supplement | 11562 | ₹4,744,609.77 |
| Antipyretic | 8923 | ₹4,022,793.09 |
| Antibiotic | 9845 | ₹2,624,159.86 |
| Antacid | 683 | ₹320,358.04 |

## Recommended management actions
1. **Prioritize collection follow-up:** Review unpaid and partially paid bills, failed transactions and the bill-level collection-gap output with the Finance/Billing team.
2. **Review high-volume operations:** Examine appointment and admission workload at the busiest hospitals and departments; compare with doctor capacity, room availability and service mix.
3. **Monitor resource utilization:** Review room occupancy by hospital, room type and status before making capacity decisions.
4. **Track service costs and volumes:** Monitor treatment costs, laboratory test volumes and pharmacy sales by service/category to identify operational cost drivers.
5. **Maintain data-quality controls:** Review NULL optional fields, inconsistent gender casing, trailing spaces, malformed-looking email values and date conversions. Preserve source values until an approved correction rule exists.
6. **Use consistent financial definitions:** Confirm the treatment of refunds, failed payments and partial payments before publishing official collection KPIs.

## Limitations
- The dataset is synthetic/project data and does not establish actual MediCare performance.
- A high count means higher recorded activity, not better clinical outcomes.
- The workbook contains NULL values in optional relationships and attributes; do not automatically convert them to zero.
- The collection gap is an analytical estimate based on successful payments less refunded payments and should be validated with Finance.