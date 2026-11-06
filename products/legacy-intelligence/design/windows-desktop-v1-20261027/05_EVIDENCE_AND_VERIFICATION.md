# مصادر القرار وحدود التحقق

2026-10-27 · [الفهرس](README.md)

## شيفرة وذاكرة فُحصتا

| المرجع | ما تحقق فعلًا | الحد |
| --- | --- | --- |
| [VISION في main](https://github.com/elias-mujally/dbl-products-memory/blob/main/products/legacy-intelligence/VISION.md)، وDECISIONS محليًا | vendor-neutral والعمل المحلي ومسار التطور وحدود AppService | عناوين حالة أكتوبر14 ليست دليل نفي للأعمال اللاحقة غير المدموجة |
| [PR #13](https://github.com/elias-mujally/dbl-products-memory/pull/13) | Draft/open؛ head=e6a615616a0bf8f7b83a1680d51571f1951400b0؛ base main ظهر عند86beaf03cceac4e39acc1d194a1577f41b749d70 | دراسة سابقة، لا اعتماد تقنية أو تطبيق |
| [AppService types](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/application-service/src/types.ts) | main blob=128da7fcdeb63a4d71c7f5981aa160c5da79f8f1؛ latest scope فقط | لا تاريخ عام أو IPC |
| [AppService exports](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/application-service/src/index.ts) | blob=bd5ba3171d0e200b287fc2307d1654ae2a76462d؛ لا Catalog في exports المشاهدة | لا ننسب Draft إلى main |
| [refreshV1File](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/apps/v1-file-import/src/index.ts) | blob=fd291ef9554406f829d4a17de61dfa02fbfad8d9 | ملف/profile محدود، لا استخراج GUI أو SQL حي |
| [operator](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/apps/v1-file-import/src/operator.ts) | blob=2d2987f7da9fe561e922d67460cd7fe137eda65f؛ فحص/تقرير/backup/verify/restore | وظائف engine، لا منحها خامًا إلى renderer |
| [Catalog AppService على S5](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/fdafd4c6b84384ca9e9eb093c9eee8beac153fa1/packages/application-service/src/catalog.ts)، [PR #27](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/27) | blob=15b7c88233009c38ecd4c31b4962f6903d6c8e91؛ PR Draft/open/unmerged على S4؛ head=fdafd4c6 | synthetic/erpQualified:false؛ لا دمج أو تأهيل ERP |
| package.json في main | blob=73c4272908423816f7ac1944056e2712f3dfc198؛ workspaces وengines>=20<23 | لا Desktop build أو ترقية runtime منفذة |
| سجل Windows10 المحلي | قبول محدود مع18 استدعاء بعينة اصطناعية، مراجعة مالك وحفظ أدلة محدد | لم نفتح الأصول أو الخزنة أو نعد الاختبار؛ لا قبول بشري جديد أو إنتاج |
| R3 المحلي الذي قبله المالك | i_code فريد حاليًا؛ ستة بدائل غير صالحة منفردة؛ Snapshot/RCSI معطلان وsysadmin فعلي | لا ثبات هوية أو مصدر ERP مؤهل؛ لا raw أو مسارات شخصية في هذا PR |

جُلبت ملفات main الأربعة أعلاه وقورنت blob SHAs بنسختها عند bccc89ec؛ تطابقت. هذا لا يثبت تطابق كل شجرة main أو CI الحالي. النسخة المحلية المتقدمة استُخدمت لفحص C1، والفارق مصرح به. البصمات المحلية للملفات14 المقروءة في manifest تعيد تعريف ما راجعناه دون تغييرها.

## مراجع رسمية للتقنيات

- [Electron Security](https://www.electronjs.org/docs/latest/tutorial/security): سلطات التطبيق ومحتواه وsender/navigation؛ سياسات التقرير مقترحة وليست ضمانًا منفذًا.
- [Context Isolation](https://www.electronjs.org/docs/latest/tutorial/context-isolation) و[IPC](https://www.electronjs.org/docs/latest/tutorial/ipc): حدود preload/renderer والجسر المقيد. لم ننفذ أمثلة الصفحات.
- [Native Node Modules](https://www.electronjs.org/docs/latest/tutorial/using-native-node-modules): اختلاف ABI؛ قرار Node مستقل يخص DBL.
- [utilityProcess](https://www.electronjs.org/docs/latest/api/utility-process): child Node بآلية Electron؛ لا مساواة مفترضة مع runtime مستقل مؤهل.
- [Tauri Windows installer](https://v2.tauri.app/distribute/windows-installer/) و[sidecar](https://v2.tauri.app/develop/sidecar/): نشر WebView2 دون إنترنت وتضمين binary؛ أرقام أمثلة الموقع ليست benchmark لـDBL.
- [WPF وRTL](https://learn.microsoft.com/en-us/dotnet/desktop/wpf/advanced/use-automatic-layout-overview) و[Windows App SDK deployment](https://learn.microsoft.com/en-us/windows/apps/package-and-deploy/deploy-overview): قدرات بديلة ونشر؛ صفحة choose-framework المباشرة تعذر جلبها، فلا نزعم قراءتها كاملة.
- [Node releases](https://nodejs.org/en/about/previous-releases): Node22 مدرج LTS و20 EOL وقت البحث؛ ليس تأهيلًا لأمان patch محفوظ.
- [Microsoft Windows10 end of support](https://www.microsoft.com/en-us/windows/end-of-support): انتهى الدعم العام في2025-10-14؛ لا ESU مفترض للمالك.
- [WCAG 2.2 quick reference](https://www.w3.org/WAI/WCAG22/quickref/): أهداف للفحص اللاحق، لا شهادة وصول.

هذه وثائق خصائص تقنيات، لا إثبات أداء أو سلامة حزمة DBL الجديدة. لم ننزل تبعيات أو أصولًا، ولم ننفذ أوامر تثبيت أو تعديل من الصفحات.

## التحقق المنفذ وحدوده

نُفذت قراءات محددة للكود والذاكرة والـPRs، وفحص design context الذي لم يكن موجودًا، وصياغة المقترح. فُحصت الروابط النسبية وبصمات الوثائق والنصوص ضد معرفات خاصة محددة، وبقاء ملفات المنتج14 المقروءة ثابتة. فحص النصوص محدود وليس ماسح أسرار شاملًا.

لم يُنفذ build/typecheck أو CI جديد أو UI/visual prototype أو IPC أو benchmark أو أي معيار A01–A18 أو قبول Windows/إنسان جديد. لم تُفتح ERP/SQL/SQLite أو بيانات raw أو الخزنة؛ لم نُشغّل أوامر المشغّل أو نعدل Preview1 أو العقود أو المخططات أو إعدادات الجهاز.

الجداول وMermaid مواصفات معمارية، لا صور شاشة أو أصول UI أو منتج عامل. manifest سلامة وثائق فقط. نشر المقترح في Draft PR مأذون؛ دمجه أو تنفيذه أو نشر binary يحتاج قرارًا مستقلًا.
