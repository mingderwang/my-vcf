# 現用藥物 × 基因交互作用指引

- 對應基因報告：`pgx/report/pgx_report_zhTW.md`
- 參考基因體：GRCh37/hg19
- 免責聲明：本指引僅供教育研究用途，不構成醫療建議。用藥調整請洽醫師或藥師。

## 現用藥品

| 藥品 | 成分 | 適應症 | 劑量 |
|---|---|---|---|
| Anxolightor（善脂瑩）F.C. Tablets 20 mg | Atorvastatin | 高膽固醇血症、高三酸甘油脂血症 | 20 mg |
| Celebrex（希樂葆）200 mg | Celecoxib | 止痛／抗發炎（NSAID） | 200 mg |
| 得安穩 160 mg | Valsartan | 高血壓（ARB） | 160 mg |
| Benrone（免痛錠）100 mg | Benzbromarone | 降尿酸（促進尿酸排泄） | 100 mg |
| Ativan（安定文）0.5 mg | Lorazepam | 抗焦慮（苯二氮平類） | 0.5 mg |
| Tofranil（妥富腦）10 mg | Imipramine | 三環抗憂鬱劑（TCA） | 10 mg |
| Solaxin（舒肉筋新錠）200 mg | Chlorzoxazone | 骨骼肌鬆弛劑 | 200 mg |
| Traceton（服安痛）F.C. Tablets | Tramadol 37.5 mg + Acetaminophen 325 mg | 中度疼痛（複方止痛，第4級管制藥） | 37.5/325 mg |
| Acetal（愛舒疼）500 mg | Acetaminophen | 止痛退燒 | 500 mg |

## 藥物 × 基因矩陣

| 藥品 | 相關基因 | 你的基因型 | 代謝表現型 | 臨床建議 |
|---|---|---|---|---|
| Atorvastatin | SLCO1B1 | *1/*1 | 正常轉運蛋白活性 | 標準劑量即可；他汀類肌肉病變風險低。 |
| Celecoxib | CYP2C9 | *1/*1 | 正常代謝者 | 不需調整劑量。 |
| Valsartan | — | — | 非 CYP 依賴代謝 | 無基因限制。 |
| Benzbromarone | — | — | 非 allopurinol | 無 HLA-B\*58:01 風險，不需先行基因檢測。 |
| Lorazepam | —（UGT 葡萄醣醛酸化） | UGT1A1 *1/*1 正常 | 無基因限制。 |
| Imipramine | CYP2C19（去甲基化）、CYP2D6 | CYP2C19 *1/*2；CYP2D6 *1/*1（暫定） | CPIC：CYP2C19 中間代謝者起始劑量可考慮減 25%，依療效與血中濃度調整；此處 10 mg 為極低劑量，風險低。 |
| Chlorzoxazone | —（CYP2E1 代謝） | — | 無基因限制。 |
| Tramadol | **CYP2D6（前驅藥活化）** | **CYP2D6 *1/*1（暫定，拷貝數未評估）** | 正常代謝者可標準用藥；因拷貝數變異未評估，仍建議低劑量起始並留意療效與副作用（CPIC）。 |
| Acetaminophen | — | — | 無基因限制。 |

**結論：四種主要慢病用藥不需依基因調整；Imipramine 受 CYP2C19 \*1/\*2 影響（極低劑量下風險有限），Tramadol 依暫定 CYP2D6 \*1/\*1 為正常代謝者，但拷貝數變異未納入評估。**

## NSAID 交叉不耐受（ibuprofen / diclofenac 過敏）

你對 ibuprofen（布洛芬）與 diclofenac（服他靈/非炎/扶他林，Voltaren）皆有過敏反應，兩者屬不同化學類別 → 高度符合**交叉不耐受**：非免疫機制，由**抑制 COX-1** 使花生四烯酸轉入白三烯（leukotriene）路徑所致。因此對**所有非選擇性 NSAID 都會反應**。

- **應終身避免**：ibuprofen、diclofenac、naproxen、ketoprofen、mefenamic acid、aspirin、indomethacin 等所有非選擇性 NSAID，**含外用製劑**（如 Voltaren Gel、Voren 凝膠）。
- **通常可耐受**：選擇性 COX-2 抑制劑 **celecoxib（Celebrex，你目前正在服用）、etoricoxib**——你耐受 celecoxib 與此診斷一致。
- **Acetaminophen（Acetal、Traceton 內含）**：低劑量（≤1000 mg/日）多數可耐受；高劑量下約 25% 的交叉不耐受者仍可能反應，注意勿超量。
- **基因標記（僅供研究）**：VCF 中 LTC4S/PTGS1/PTGS2/ALOX5 標記多為同型合子參考型（ALOX5 rs2115819 同型合子變異型、rs12762303 異型合子）。這些為關聯研究、**不具臨床預測力**，無法解釋或排除此過敏；確診請由過敏免疫科安排口服激發試驗。
- **緊急警訊**：若服用任何 NSAID 後出現呼吸困難、臉/唇腫脹、全身性紅疹或意識改變，立即就醫。

## 跨藥交互作用提醒

- **Tramadol + Imipramine**：兩者皆具血清素作用並降低癲癇閾值，併用可能引起**血清素症候群**（躁動、體溫升高、心跳加快）或癲癇；出現上述症狀應立即回診。Imipramine 亦可能增強 tramadol 之中樞抑制。
- **重複 Acetaminophen**：Traceton 每錠含 acetaminophen 325 mg，再加 Acetal 500 mg 易超量，**每日總量勿超過 4000 mg**，並避免與其他綜合感冒藥重複。
- **鎮靜加成**：Lorazepam + Chlorzoxazone + Tramadol 皆抑制中樞神經，會增強嗜睡、跌倒與呼吸抑制風險；用藥期間避免開車與操作機械。
- **Lorazepam 依賴性**：苯二氮平類長期使用有成癮與戒斷風險，短期、按醫囑使用。

## 注意事項

- **CYP2C19 \*1/\*2（中間代謝者）**：目前不影響上述任一藥品。若未來加開 PPI 胃藥，omeprazole、lansoprazole 效果可能降低，建議改用 esomeprazole 或 rabeprazole。
- **NSAID + ARB 併用**：celecoxib（NSAID）與 valsartan（ARB）併用可能減弱降壓效果，並增加腎功能與血鉀風險，建議定期追蹤血壓與腎功能。
- **HLA-B\*58:01 未檢測**：目前用藥為 benzbromarone（排尿酸），無此風險。若未來改用 **allopurinol**，務必先檢測 HLA-B\*58:01（華人帶因率約 12–22%）。
- **Atorvastatin 交互作用**：屬 CYP3A4 受質，現用藥中無強效 CYP3A4 抑制劑；若未來併用 clarithromycin、azole 類抗黴菌藥或強效 grapefruit 則需調整劑量。
- 本指引未涵蓋藥物－藥物交互作用之完整評估，請以藥袋說明與醫療專業意見為準。
