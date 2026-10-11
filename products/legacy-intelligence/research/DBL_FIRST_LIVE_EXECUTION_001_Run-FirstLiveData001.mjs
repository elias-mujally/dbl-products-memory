import {readFile,writeFile,access} from 'node:fs/promises';
import {createHash,X509Certificate} from 'node:crypto';
import {createRequire} from 'node:module';
import {pathToFileURL} from 'node:url';
import {execFileSync} from 'node:child_process';
import {lookup} from 'node:dns/promises';
import net from 'node:net';
import dc from 'node:diagnostics_channel';
import path from 'node:path';
const root='C:\\Users\\user\\Documents\\Codex\\2026-08-25\\files-pasted-by-the-user-dbl';
const task=path.join(root,'outputs','host-first-live-data-001-20261010');
const repo=path.join(root,'work','dbl-legacy-intelligence');
const require=createRequire(path.join(repo,'package.json'));
const mode=process.argv[2];
const ps='C:\\Users\\user\\.cache\\codex-runtimes\\codex-primary-runtime\\dependencies\\native\\powershell\\pwsh.exe';
const sha=b=>createHash('sha256').update(b).digest('hex').toUpperCase();
const need=(ok,code)=>{if(!ok){const e=new Error();e.safeCode=code;throw e;}};
const safe=e=>e?.safeCode??(/^(MOTAKAMEL_|SQLITE_|IMPORT_|AUDIT_|APPLICATION_)[A-Z0-9_]+$/.test(e?.code??'')?e.code:'BOUNDED_GATE_FAILED');
const result={Decision:'FIRST_LIVE_DATA_001_BLOCKED_STOP',At:null,Phase:'Runtime',TLS:'NOT_TESTED',Reader:'NOT_TESTED',Import:'NOT_TESTED',SnapshotReader:'NOT_TESTED',FirstLiveData:'NOT_TESTED',SQLConnection:false,FixtureOrMock:false,HostMutation:false,Retry:false,CleanupFailures:[]};
let connector,store,audit,password='',manifest,primary,subscriptions=[];
const file=n=>path.join(task,'FIRST_LIVE_DATA_001_'+n);
const fresh=async p=>{try{await access(p);need(false,'EXISTING_ARTIFACT_NO_OVERWRITE');}catch(e){if(e.code!=='ENOENT')throw e;}};
const json=async(p,v)=>writeFile(p,JSON.stringify(v,null,2),{flag:'wx',encoding:'utf8'});
const collect=async iterable=>{const a=[];for await(const v of iterable){a.push(v);need(a.length<=2,'BOUNDED_RECORD_BUDGET');}return a;};
const environment=()=>{
 const value=JSON.parse(execFileSync(ps,['-NoProfile','-File',path.join(task,'Read-FirstLiveEnvironment001.ps1')],{encoding:'utf8',timeout:20000,stdio:['ignore','pipe','pipe']}));
 need(value.Decision==='CURRENT_LIVE_ENVIRONMENT_READONLY_PASSED','CURRENT_ENVIRONMENT');return value;
};
async function prerequisites(){
 need(process.version==='v22.23.2'&&process.platform==='win32'&&process.arch==='x64','PINNED_NODE22');
 for(const key of ['NODE_TLS_REJECT_UNAUTHORIZED','NODE_EXTRA_CA_CERTS','NODE_OPTIONS','SSLKEYLOGFILE','DEBUG','DBL_MOTAKAMEL_READER_PASSWORD'])need(!process.env[key],'UNSAFE_OR_SECRET_ENVIRONMENT');
 manifest=JSON.parse(await readFile(file('BUILD_PINS.json'),'utf8'));
 for(const entry of manifest.Files)need(sha(await readFile(entry.Path))===entry.SHA256,'BUILD_OR_HELPER_PIN_CHANGED');
 need(execFileSync('git',['-C',repo,'rev-parse','HEAD^{tree}'],{encoding:'utf8',stdio:['ignore','pipe','pipe']}).trim()==='51f15b2a1113fc3742559f7d76dab350fb8bb83c','MERGED_MAIN_TREE');
 need(!execFileSync('git',['-C',repo,'diff','--name-only','HEAD'],{encoding:'utf8',stdio:['ignore','pipe','pipe']}).trim(),'TRACKED_CODE_DIRTY');
 for(const [name,version] of [['mssql','12.7.4'],['tedious','20.3.3'],['better-sqlite3','11.8.1']])need(require(name+'/package.json').version===version,'LOCKED_DRIVER_VERSION');
 const load=async n=>import(pathToFileURL(require.resolve(n)).href);
 const modules={connector:await load('@dbl/connector-motakamel-plus'),storage:await load('@dbl/storage-sqlite'),importer:await load('@dbl/import-orchestrator'),audit:await load('@dbl/audit-sqlite'),app:await load('@dbl/application-service'),insights:await load('@dbl/insights'),query:await load('@dbl/query-engine')};
 const Native=require('better-sqlite3');const db=new Native(':memory:');db.close();
 const pem=await readFile(path.join(repo,'packages','connectors-motakamel-plus','test','support','lab-ca-public.pem'),'utf8');
 const ca=new X509Certificate(pem);need(ca.ca&&sha(ca.raw)==='A3FBC7905425B2E8C10F3A070B8713F876B94FC42B8D1243DEAD5D0F42889472','EXCLUSIVE_PUBLIC_CA');
 const env=environment();const addresses=await lookup('DESKTOP-8QRQT7R',{all:true});need(addresses[0]?.address==='192.168.56.1','HOSTNAME_FIRST_ROUTE_NOT_APPROVED');
 return {modules,pem,env,addresses};
}
async function tcpProbe(env){
 await new Promise((resolve,reject)=>{const s=net.connect({host:env.Address,port:env.Port});s.setTimeout(5000);s.once('connect',()=>{const okay=s.remoteAddress===env.Address&&s.remotePort===env.Port;s.destroy();if(okay)resolve();else{const e=new Error();e.safeCode='TCP_ENDPOINT_MISMATCH';reject(e);}});s.once('error',()=>{s.destroy();const e=new Error();e.safeCode='TCP_REACHABILITY_FAILED';reject(e);});s.once('timeout',()=>{s.destroy();const e=new Error();e.safeCode='TCP_REACHABILITY_TIMEOUT';reject(e);});});
}
async function secret(){
 let text='';try{for await(const chunk of process.stdin){text+=chunk.toString('utf8');need(Buffer.byteLength(text)<=16384,'SECRET_CHANNEL_BUDGET');}const v=JSON.parse(text);need(Object.keys(v).length===1&&typeof v.password==='string'&&v.password.length>0&&v.password.length<=4096,'READER_SECRET_REQUIRED');return v.password;}finally{text='';}
}
try{
 need(['check','preflight','owner-preflight','live'].includes(mode),'MODE');const ready=await prerequisites();const {modules,pem,env,addresses}=ready;result.Environment=env;result.Node=process.version;result.BuildTree=manifest.Tree;result.PublicCA_SHA256=sha(new X509Certificate(pem).raw);
 if(mode==='check'){console.log(JSON.stringify({Decision:'LIVE_RUNNER_MODULES_PINS_CHECK_PASSED',SQLConnection:false,TCPProbe:false,NativeSQLiteModuleLoaded:true}));}
 else if(mode==='preflight'||mode==='owner-preflight'){
  result.Phase='TCPReachability';const target=file(mode==='preflight'?'PREFLIGHT.json':'OWNER_PREFLIGHT.json');await fresh(target);await tcpProbe(env);const again=environment();need(again.Pid===env.Pid&&again.Port===env.Port,'ENDPOINT_CHANGED_DURING_PREFLIGHT');
  await json(target,{Decision:'LIVE_PREREQUISITES_PASSED_SECRET_PENDING',At:new Date().toISOString(),Environment:env,HostnameAddresses:addresses,Runtime:process.version,CodeTree:manifest.Tree,TCPReachability:'PASSED_ONE_NO_AUTH_PROBE',TLS:'NOT_TESTED',Reader:'NOT_TESTED',FirstLiveData:'NOT_TESTED',HostMutation:false});console.log(JSON.stringify({Decision:'LIVE_PREREQUISITES_PASSED_SECRET_PENDING',Port:env.Port,Pid:env.Pid,TLS:'NOT_TESTED'}));
 }else{
  result.Phase='FreshLiveBoundary';for(const n of ['ATTEMPT.json','RESULT.json','CANONICAL.json','snapshot.sqlite','audit.sqlite'])await fresh(file(n));const owner=JSON.parse(await readFile(file('OWNER_PREFLIGHT.json'),'utf8'));need(owner.Environment.Pid===env.Pid&&owner.Environment.Port===env.Port&&Date.now()-Date.parse(owner.At)<600000,'FRESH_OWNER_PREFLIGHT');
  await json(file('ATTEMPT.json'),{Task:'FIRST_LIVE_DATA_001',At:new Date().toISOString(),Environment:env,MaxCallerAttempts:1,NoFixture:true,NoHostChanges:true});
  result.Phase='SecureReaderHandoff';password=await secret();
  const transport={port:env.Port,caCertificatePem:pem};connector=new modules.connector.MotakamelPlusItemIdentityConnector({passwordProvider:()=>password,directTcp:transport});
  const observations=[];const channel=dc.channel('mssql:connection:create');const observe=x=>{observations.push({server:x.server,database:x.database,connectionId:x.connectionId});};channel.subscribe(observe);subscriptions.push([channel,observe]);
  result.Transport={encrypt:true,trustServerCertificate:false,ServerName:'DESKTOP-8QRQT7R',MinTLS:'TLSv1.2',ExclusiveCA_SHA256:result.PublicCA_SHA256,DirectPort:env.Port,InstanceDiscovery:false,TransientLoginRetries:0};
  result.Phase='ProductionConnectorConnectionQualification';result.SQLConnectionAttempted=true;const health=await connector.testConnection();need(health.ok,'CONNECTOR_HEALTH');result.SQLConnection=true;
  result.TLS='PASSED_SUCCESSFUL_STRICT_PRODUCTION_DRIVER_CONNECTION';result.TLSProof='Successful actual encrypted driver connection with pinned-only CA and normal hostname validation; negotiated cipher/peer socket not separately captured';result.Reader='PASSED_FIXED_DB_ID_READ_ONLY_LOGIN_SCHEMA_PERMISSION_GUARDS';
  result.Phase='RealItemAcquisition';const acquired=await connector.exportAcquisition();need(JSON.stringify(acquired.products)===JSON.stringify([{id:'DBL_P001_ITEM_A',name:'DBL_ITEM_A'}])&&acquired.customers.length===0&&acquired.sales.length===0,'EXACT_LIVE_ITEM');await json(file('CANONICAL.json'),acquired);
  result.Phase='ImportOrchestratorToSQLite';store=new modules.storage.SqliteLocalStore({filename:file('snapshot.sqlite')});await store.initialize();audit=new modules.audit.SqliteAuditSink({databasePath:file('audit.sqlite')});
  const importer=new modules.importer.ImportOrchestrator(store,audit,{retryPolicy:{maxAttempts:1,baseDelayMs:0,maxDelayMs:0,shouldRetry:()=>false}});const imported=await importer.importFrom(connector);need(imported.snapshotId===acquired.snapshotId&&imported.attempts===1&&imported.batchesProcessed===1&&imported.auditComplete,'IMPORT_CHECKPOINT');need(JSON.stringify(imported.checkpoint.recordCounts)===JSON.stringify({products:1,customers:0,sales:0}),'EXACT_COUNTS');
  const cps=await store.listCheckpoints();need(cps.length===1&&cps[0].snapshotId===acquired.snapshotId,'ONE_COMMITTED_CHECKPOINT');result.Import='PASSED';result.ImportResult=imported;
  result.Phase='SQLiteSnapshotReader';const reader=await store.openLatestSnapshotReader(connector.metadata.id);need(reader&&reader.header.snapshotId===acquired.snapshotId&&reader.header.capturedAt===acquired.capturedAt&&JSON.stringify(reader.header.source)===JSON.stringify(acquired.source),'SNAPSHOT_PROVENANCE');const products=await collect(reader.products());need(JSON.stringify(products)===JSON.stringify(acquired.products)&&(await collect(reader.customers())).length===0&&(await collect(reader.sales())).length===0,'READER_COUNTS_AND_ITEM');result.SnapshotReader='PASSED';result.Product=products[0];result.Header=reader.header;
  const app=new modules.app.DefaultLegacyIntelligenceApplication({store,insightEngine:new modules.insights.DeterministicInsightEngine([])});const scope=await app.openReadScope({connectorId:connector.metadata.id});const query=await scope.query({version:modules.query.QUERY_PLAN_VERSION,entity:'product',filters:[{field:'id',op:'eq',value:'DBL_P001_ITEM_A'}]});need(JSON.stringify(query.items)===JSON.stringify(acquired.products)&&query.snapshotId===acquired.snapshotId,'DBL_APPLICATION_QUERY');result.ApplicationQuery='PASSED';
  result.AuditActions=(await audit.list()).map(e=>e.action);need(!result.AuditActions.includes('import.retry')&&result.AuditActions.includes('import.completed'),'NO_IMPORT_RETRY');result.DriverConnectionObservations=observations;need(observations.length<=8&&observations.length>0&&observations.every(x=>x.server==='DESKTOP-8QRQT7R'&&x.database==='DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009'),'BOUNDED_REAL_DRIVER_SOURCE');
  result.Phase='PostReadEnvironment';const after=environment();need(after.Pid===env.Pid&&after.Port===env.Port,'SOURCE_SERVICE_ENDPOINT_UNCHANGED');result.PostEnvironment=after;result.FirstLiveData='PASSED';result.Decision='FIRST_LIVE_DATA_001_PASSED';
 }
}catch(e){primary={Phase:result.Phase,Code:safe(e),CleanupCode:e?.cleanupFailure?.code==='MOTAKAMEL_READER_CLOSE_FAILED'?'MOTAKAMEL_READER_CLOSE_FAILED':null,RawErrorPublished:false};result.Failure=primary;process.exitCode=1;}
finally{
 for(const [ch,fn] of subscriptions)ch.unsubscribe(fn);
 for(const [name,resource] of [['Connector',connector],['Storage',store],['Audit',audit]])if(resource)try{await resource.close();}catch{result.CleanupFailures.push(name+'_CLOSE_FAILED');}
 password='';if(result.CleanupFailures.length){result.Decision='FIRST_LIVE_DATA_001_BLOCKED_STOP';result.FirstLiveData='PARTIAL';process.exitCode=1;}
 if(mode==='live'){
  result.At=new Date().toISOString();result.Pending='STOP; do not rerun, change source/security, or expand the identity slice';
  for(const [name,n] of [['SQLite','snapshot.sqlite'],['AuditSQLite','audit.sqlite'],['Canonical','CANONICAL.json']])try{result[name+'SHA256']=sha(await readFile(file(n)));}catch{if(result.FirstLiveData==='PASSED'){result.FirstLiveData='PARTIAL';result.Decision='FIRST_LIVE_DATA_001_BLOCKED_STOP';process.exitCode=1;}}
  try{await json(file('RESULT.json'),result);console.log(JSON.stringify(result,null,2));}catch{console.log(JSON.stringify({Decision:'FIRST_LIVE_DATA_001_RESULT_PUBLICATION_BLOCKED',FirstLiveData:'NOT_PROVEN',RawErrorPublished:false}));process.exitCode=1;}
 }else if(primary){console.log(JSON.stringify({Decision:'LIVE_PREFLIGHT_BLOCKED_STOP',Failure:primary,SQLConnection:false,NoAutomaticRetry:true}));}
}
