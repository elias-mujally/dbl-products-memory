# Sources & Verification

2026-10-25 · مراجع بحث وقراءة، لا نتائج تشغيل أطر UI · [الفهرس](README.md).

## كود المنتج الذي فُحص

رأس GitHub main هو bccc89ecb077b11ec5476b82a222ed9c4a3487b9 وشجرته f1988518b45b94ef303ae79eb0eabb761fd12aa6. الشجرة المحلية النظيفة المقروءة مطابقة؛ اختلاف commit المحلي لا يعني اختلاف المصدر. لم يُكتب كود منتج أو يُشغّل المحرك/Preview1 في هذه المرحلة.

| ID | المصدر الثابت | ما يثبت وحدوده |
| --- | --- | --- |
| K01 | [operator.ts](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/apps/v1-file-import/src/operator.ts)، [operator-cli.ts](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/apps/v1-file-import/src/operator-cli.ts) | الأوامر ومخرجات check/status/report/backup/verify/restore، وقيد خمسة منتجات. لا Desktop API أو سجل صفوف عمليات جاهز |
| K02 | [v1-inventory.ts](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/connectors-motakamel-plus/src/v1-inventory.ts)، [v1-acquisition.ts](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/connectors-motakamel-plus/src/v1-acquisition.ts) | profile وهوية ومصالحة حركات/تكلفة؛ raw<=4MiB. ليس ERP عامًا |
| K03 | [index.ts](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/apps/v1-file-import/src/index.ts)، [state.ts](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/apps/v1-file-import/src/state.ts) | admission/replay/order/audit وحدود state؛ تعليق صريح بأن POSIXmode لا يؤهل WindowsACL |
| K04 | [application service](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/application-service/src/service.ts)، [query types](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/query-engine/src/types.ts)، [executor](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/query-engine/src/executor.ts) | latestsnapshot ثابت وفلاتر/cursor؛ لا sort field أو واجهة تاريخ GUI |
| K05 | [inventory-value.ts](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/insights/src/inventory-value.ts)، [rules.ts](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/insights/src/rules.ts) | حساب قيمة decimal وتغطية جزئية؛ lowstock عتبة DBL. قواعد مبيعات/ذمم عامة لا تثبت اقتناء بياناتها في V1 |
| K06 | [launcher.cjs](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/tools/windows-delivery/launcher.cjs)، [package metadata](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/apps/v1-file-import/package.json) | manifest/runtime/ABI/paths/arity و Node22/better-sqlite3؛ ack ليس ACLtest أو GUI |

قُرئت اختبارات operator/query لتحديد assertions الموجودة؛ **لم تُعد تشغيلها**. لا واجهة Desktop مؤهلة في هذا الأساس. هذا لا يدعي غياب كل تجربة في مسارات خارج الشجرة.

## ذاكرة المشروع

| ID | المرجع | حدود الاعتماد |
| --- | --- | --- |
| M01 | [data semantics](../../engineering/v1/DATA_SEMANTICS.md)، [third capture](../../engineering/v1/THIRD_CAPTURE_RESULT.md)، [operator handover](../../engineering/v1/OPERATOR_HANDOVER.md) | أدلة سابقة للعينة والفرق الحقيقي وقبول وكيل ثانٍ؛ ليست GUI أو تجربة عميل |
| M02 | [PR12](https://github.com/elias-mujally/dbl-products-memory/pull/12)، [سجل Windows10 المقترح](https://github.com/elias-mujally/dbl-products-memory/blob/a8cab65ea7c4a1a8059c58d23359d2b1456c5bc8/products/legacy-intelligence/engineering/v1/WINDOWS10_CLEAN_ACCEPTANCE_20261024.md)، [البوابات](https://github.com/elias-mujally/dbl-products-memory/blob/a8cab65ea7c4a1a8059c58d23359d2b1456c5bc8/products/legacy-intelligence/engineering/v1/V1_REMAINING_GATES_20261024.md) | PR مفتوح وقت الفحص؛ قبول CLI وإفادة المالك والتحقق من الإيصال المحدود منفصلة. لا وصول للأصول الخاصة |
| M03 | [first customer discovery](../../FIRST_CUSTOMER_DISCOVERY_2026-10-24.md) | اهتمام محتمل من مستخدم IbdaaSoft وحوالي 5000 صنف؛ ليس عقدًا أو توافقًا مثبتًا |

## مصادر الأطر الرسمية — قُرئت 2026-10-25

- E1: [Electron security](https://www.electronjs.org/docs/latest/tutorial/security) و[sandbox](https://www.electronjs.org/docs/latest/tutorial/sandbox). توثق فصل صلاحيات renderer؛ ضبطها وتقييم وسائط DBL واجب تطوير، لا ضمانًا تلقائيًا.
- E2: [Native Node modules](https://www.electronjs.org/docs/latest/tutorial/using-native-node-modules). ABI مختلف؛ native modules تحتاج بناءً مناسبًا. لذلك اقترحنا Node مستقلًا بدل تحميل binding الحالي مباشرة.
- E3: [IPC](https://www.electronjs.org/docs/latest/tutorial/ipc)، [testing](https://www.electronjs.org/docs/latest/tutorial/automated-testing)، [distribution](https://www.electronjs.org/docs/latest/tutorial/distribution-overview)، [autoUpdater](https://www.electronjs.org/docs/latest/api/auto-updater). إمكانات وأدوات، لا دليل اختبار تكامل أو تفعيل تحديثات في DBL.
- T1: [Tauri sidecars](https://v2.tauri.app/develop/sidecar/) و[capabilities](https://v2.tauri.app/security/capabilities/). يدعمان binary خارجيًا وحدود أوامر؛ لا يجوز منح shell/fs عامة للواجهة.
- T2: [Windows installer/WebView2](https://v2.tauri.app/distribute/windows-installer/) و[prerequisites](https://v2.tauri.app/start/prerequisites/). التشغيل دون إنترنت يحتاج اختيار runtime واضحًا واحتساب تكلفته؛ حجم غلاف فارغ ليس حجم DBL الكامل.
- N1: [WinUI3](https://learn.microsoft.com/en-us/windows/apps/winui/winui3/) و[deployment](https://learn.microsoft.com/en-us/windows/apps/package-and-deploy/deploy-overview). إطار أصلي وتبعيات نشر؛ لا يفرضان نقل SQLite إلى.NET.
- N2: [WPF bidirectional features](https://learn.microsoft.com/en-us/dotnet/desktop/wpf/advanced/bidirectional-features-in-wpf-overview) و[.NET deployment](https://learn.microsoft.com/en-us/dotnet/core/deploying/single-file/overview). FlowDirection وخيارات self-contained؛ لا قياس حجم/أداء لتطبيقنا.

## Accessibility

[WCAG2.2](https://www.w3.org/TR/WCAG22/)، [contrast](https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum.html)، [Windows text scaling](https://learn.microsoft.com/en-us/windows/apps/develop/input/text-scaling)، [globalization](https://learn.microsoft.com/en-us/windows/apps/design/globalizing/globalizing-portal)، [Segoe UI scripts](https://learn.microsoft.com/en-us/typography/font-list/segoe-ui). استُخدمت لتحديد أهداف التباين والتنسيق والوصول والخط. حساب ألوان لا يغلق اختبار مكونات أو عربية فعلية، ولا يبيح توزيع ملفات خط نظامية.

## ما اختُبر هنا

قراءة مستودعات وشجرات ومصدر معلن ومراجع رسمية، وفحص تغطية وروابط وخصوصية الوثائق، وحساب contrast لأزواج tokens محددة بأداة محلية قياسية. لا build لـ Electron/Tauri/WPF، ولا prototype/UI rendering، ولا قياس ذاكرة/حجم أداء، ولا إعادة اختبار المحرك أو ACL/Defender.

لم تُثبت تبعيات أو تتغير إعدادات أو يُفتح ERP أو خزنة الأدلة. لا customer raw أو SQLite أو HTML خاص أو أصول شخصية في الوثائق. الاقتراحات والافتراضات معلنة؛ لا مقابلات أو هوية بصرية معتمدة. Preview1 ثابت وبصماته لم تُعد توليدها أو تعديلها.
