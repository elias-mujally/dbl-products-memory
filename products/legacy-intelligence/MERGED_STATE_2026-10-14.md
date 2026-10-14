# Legacy Intelligence — merged state, 2026-10-14

هذه هي الحالة الحالية المزامنة من مستودع الكود، وليست إعادة تأهيل للأصول الخام. مستودع الحقيقة التنفيذية: [elias-mujally/dbl-legacy-intelligence](https://github.com/elias-mujally/dbl-legacy-intelligence). فُحص `main` مباشرة عند [415ad8acef5f5754487b83408bad6c9b9c58028e](https://github.com/elias-mujally/dbl-legacy-intelligence/commit/415ad8acef5f5754487b83408bad6c9b9c58028e)، دمج PR #17. قاعدة ذاكرة المنتج قبل التحديث: `f68772c46b090bac48183f11ccbc580d9ab52ee7`؛ المسار الفعلي `products/legacy-intelligence/`.

## DONE / PARTIAL / NOT QUALIFIED / NEXT

| التصنيف | الحالة وحدودها |
|---|---|
| DONE | PR #13: الرصيد المتاح/الدفتري التاريخي المؤهل 37 UA عبر file connector وCanonical وSQLite وإعادة الفتح وSnapshotReader وApplication Service؛ metadata pinned وfail-closed compatibility. |
| DONE | PR #14: SQLite WAL engine repair وbounded Worker lifecycle؛ PR #16: fresh acknowledgement وتصحيح توقيت اختبارات العامل وتكرار WAL عبر المنصتين. |
| DONE | PR #15: Arabic application movement preview للرصيد التاريخي والفجوات؛ PR #17: أول وارد تاريخي مؤهل من صفوف المستند/السطر/الحركة نفسها. |
| PARTIAL | V1 والموصل السوقي العام؛ FIRST LIVE DATA السابق أثبت هوية صنف فقط، لا live inventory. منشأ الحركة الصفرية التاريخية لا يزال PARTIAL؛ ليست حدث وارد جديدًا. |
| NOT QUALIFIED | المنصرف، مخزون اليوم، الجرد المادي، الترحيل المحاسبي النهائي، المبيعات/الطلب، المرتجعات والحالات البديلة، multi-document/generalized movement ledger، multi-line/multi-warehouse/package، fractional float(53)/FX/valuation. |
| NOT QUALIFIED | current FindAvQty definition/attestation وlive inventory source qualification والبوابات الإدارية السابقة؛ الدمج offline لا يحول فشلها إلى نجاح. GUI/installer، live ERP integration العامة، pilot/production/release readiness غير مثبتة بهذه النتيجة. |
| NEXT | التوصية: [Outbound Evidence Discovery 001](OUTBOUND_EVIDENCE_DISCOVERY_001_PLAN.md)، evidence-first؛ إذا لا يوجد منصرف مؤهل، توسيع inbound بدليل مستقل. لم يبدأ التنفيذ. |

## الحقيقة التجارية: الحدث منفصل عن الرصيد

**HISTORICAL INBOUND MOVEMENT 001 = PASSED** للحالة المختبرية المحددة: `DBL_P001_ITEM_A` / `DBL_ITEM_A`، وارد واحد **37 UA**، شراء `1-44-1-0-1`، السطر **1**، inventory movement **serial 2**، الفرع/المخزن/العبوة **1**. تاريخ الأعمال **2026-10-08**؛ القيمة المصدرية `2026-10-08T00:00:00` SQL wall time بلا offset، لا UTC ولا وقت الحفظ.

الحالة saved cash immediate purchase، **inventory-effective، not finally GL-posted**: `Bill_post=false`، receipt `InvPost=true`، `gr_post=false`. الفاتورة والاستلام يؤكدان حركة واحدة؛ لا جمع 37+37+37. سطر الاستلام له هوية مختلفة عن سطر الفاتورة. scope المخزن من الاستلام والحركة والـmaster، لا افتراض `Bills.W_C_Code=0` مخزنًا.

الرصيد **erp.available.book.historical = 37 UA** في الصورة **as-of 2026-10-09T08:12:11+03:00** حقيقة تاريخية مستقلة عن qualifying inbound. الحدث لم يُستنتج من الرصيد أو +37 وحده؛ PR #17 يربط header/line/receipt/movement بالأدلة المثبتة. مسودة الصرف **5** أُلغيت ولم تُحفظ؛ لا تثبت outbound، و**32 unsupported**. المجهول لا يُعرض صفرًا. ليس هذا stock today أو physical count أو promise-to-sell.

## Architecture الحالية والقبول

`retained pinned evidence → HistoricalInboundFileConnector → Canonical 2.1.0 → ImportOrchestrator → isolated SQLite Product v4 → close/reopen → SnapshotReader → pinned Application Service → Arabic Markdown preview`

Observation 1.1.0 تحمل حدثًا تاريخيًا واحدًا؛ 1.0.0 balance-only باقية مدعومة. JSON الكامل في Product v4 يحفظه؛ PR #17 لا يضيف migration أو يغير SQLite engine أو TLS/Reader/live Motakamel connector. `quantityOnHand` العام لا يحمل هذا المعنى، `liveRead=false`، products=1/customers=0/sales=0. القارئ والكاتب السابقان يرفضان payload الجديدة بدل إسقاط metadata. المعاينة callable application preview **وليست GUI**.

القبول المنقول من [تقرير المنتج المثبت عند merge](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/415ad8acef5f5754487b83408bad6c9b9c58028e/docs/HISTORICAL_INBOUND_MOVEMENT_001.md) وPR #17: source-pinned one-event qualification؛ حفظ scope/date/state/provenance بعد reopen؛ منع duplicate/orphan/mismatch/draft/triple-count/version downgrade؛ EOF rollback/recovery/idempotency وclose-before-hash. ليس هذا تشغيلًا جديدًا للاختبارات في مهمة الذاكرة.

## Verification والحدود

- PR #17/local Windows Node 22.23.2: build/typecheck PASS، **365 passed / 0 failed / 1 intentionally skipped live SQL**، كما سجله PR والتقرير؛ لا ادعاء إعادة تشغيل محلية هنا.
- [CI #212](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/38608071766): GitHub run/head/job conclusions والسجلات فُحصت مباشرة؛ head **504ff3372abb74b88cfe441c5faf3264fec7581f**، Windows/Linux Node 22.23.3، **328 passed / 38 skipped / 0 failed لكل منصة**. 37 retained-artifact cases غائبة لعدم وجود owner exports و1 live SQL opt-in skipped؛ لا دليل خام بديل.
- **10 fresh Worker/WAL cycles لكل OS، 22 cases/cycle، 220 executions/platform، 0 failures**؛ cycle starts وWAL_REPEAT_PASSED موجودة في السجلين. build/typecheck نجحا؛ critical audit على Linux فقط حسب workflow.
- Original owner-retained FACT/qualification/S2 evidence، BAK وSQLite/acceptance outputs ليست في Git ولم تُفتح أو تُعاد بصمتها هنا. هذه مراجعة repo/docs/CI، **لا independent raw verification**. السجل [Evidence Register](EVIDENCE_REGISTER_2026-10-14.md) يفصل المنقول عن المفحوص مباشرة.
- تقرير PR #17 حفظ receipt الأصلي ذي audit hash قبل WAL close، وصححه بـFINAL_ARTIFACT_HASHES بعد close/read-only verification. لا تخلط هذا مع SQLite/receipt تجربة balance-only السابقة أو تستبدل بصماتها.

## Risks وtraceability

Finite WAL repetitions ليست ضمانًا لكل OS/filesystem/power-loss أو stall في parent/native؛ لا multi-process coordination أو cross-file atomicity عامة. SQLite safety إصلاح اعتماد upstream، لا ادعاء فساد DBL سابق مثبت. moderate sprintf-js/Tedious findings والـrunner annotations لا تُمحى بالـgreen critical gate. representative performance، retention/backup، packaging/UI responsiveness وغيرها من pre-pilot gates تبقى في roadmap التاريخية إلى أن تُؤهل منفصلًا.

قرارات الرؤية read-only/local-first وAI optional وimplement-first ثابتة. [Architecture](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/415ad8acef5f5754487b83408bad6c9b9c58028e/docs/ARCHITECTURE.md)، [Application boundary](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/415ad8acef5f5754487b83408bad6c9b9c58028e/docs/APPLICATION_SERVICE.md)، [Storage](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/415ad8acef5f5754487b83408bad6c9b9c58028e/docs/PERSISTENCE_FOUNDATION.md). [Audit inventory](MEMORY_AUDIT_2026-10-14.md) يسجل كل ملف سابق؛ التقارير/JSON/helpers التاريخية محفوظة ولا تُنفّذ. موافقات STOP القديمة تخص محاولاتها لا حالة main الحالية.

مهمة الذاكرة: documentation-only branch + Draft PR؛ لا code repo edits أو SQL/ERP أو production/deploy/release. **لا دمج طلب الذاكرة بدون موافقة مالك صريحة منفصلة.**
