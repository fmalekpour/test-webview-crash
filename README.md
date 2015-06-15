# test-webview-crash
A test app that shows the WebThread crash caused by AdMob

This app demonstrates the WebTread bug that caused the crash in iOS, here is the back trace:

	* thread #7: tid = 0x1252aa, 0x09658e63 JavaScriptCore`WTFCrash + 67, name = 'WebThread', stop reason = EXC_BAD_ACCESS (code=1, address=0xbbadbeef)
		frame #0: 0x09658e63 JavaScriptCore`WTFCrash + 67
		frame #1: 0x09462166 JavaScriptCore`JSC::JSLock::DropAllLocks::DropAllLocks(JSC::VM*) + 198
		frame #2: 0x05815c2e WebCore`SendDelegateMessage(NSInvocation*) + 110
		frame #3: 0x046e9c75 WebKitLegacy`-[_WebSafeForwarder forwardInvocation:] + 53
		frame #4: 0x0082004e CoreFoundation`___forwarding___ + 478
		frame #5: 0x0081fe4e CoreFoundation`__forwarding_prep_0___ + 14
		frame #6: 0x046b377b WebKitLegacy`WebChromeClientIOS::setNeedsScrollNotifications(WebCore::Frame*, bool) + 123
		frame #7: 0x04b21b19 WebCore`WebCore::DOMWindow::removeAllEventListeners() + 185
		frame #8: 0x04a7edd2 WebCore`WebCore::Document::removeAllEventListeners() + 34
		frame #9: 0x04a75268 WebCore`WebCore::Document::~Document() + 248
		frame #10: 0x04cbf190 WebCore`WebCore::HTMLDocument::~HTMLDocument() + 16
		frame #11: 0x0534e4fb WebCore`WebCore::Node::~Node() + 235
		frame #12: 0x04ce5930 WebCore`WebCore::HTMLHtmlElement::~HTMLHtmlElement() + 16
		frame #13: 0x050ff59f WebCore`WebCore::JSNodeOwner::finalize(JSC::Handle<JSC::Unknown>, void*) + 415
		frame #14: 0x0962396e JavaScriptCore`JSC::WeakBlock::sweep() + 110
		frame #15: 0x096259c8 JavaScriptCore`JSC::WeakSet::sweep() + 40
		frame #16: 0x09503e2c JavaScriptCore`JSC::MarkedBlock::sweep(JSC::MarkedBlock::SweepMode) + 28
		frame #17: 0x09503a65 JavaScriptCore`JSC::MarkedAllocator::tryAllocateHelper(unsigned long) + 229
		frame #18: 0x09502b70 JavaScriptCore`JSC::MarkedAllocator::allocateSlowCase(unsigned long) + 144
		frame #19: 0x09216b97 JavaScriptCore`JSC::constructDate(JSC::ExecState*, JSC::JSGlobalObject*, JSC::ArgList const&) + 2631
		frame #20: 0x09216c3e JavaScriptCore`JSC::constructWithDateConstructor(JSC::ExecState*) + 46
		frame #21: 0x094f2a24 JavaScriptCore`JSC::LLInt::setUpCall(JSC::ExecState*, JSC::Instruction*, JSC::CodeSpecializationKind, JSC::JSValue, JSC::LLIntCallLinkInfo*) + 308
		frame #22: 0x094eed06 JavaScriptCore`llint_slow_path_construct + 182
		frame #23: 0x094f8429 JavaScriptCore`llint_entry + 17300
		frame #24: 0x094f8356 JavaScriptCore`llint_entry + 17089
		frame #25: 0x094f3f16 JavaScriptCore`callToJavaScript + 261
		frame #26: 0x093d1e81 JavaScriptCore`JSC::JITCode::execute(JSC::VM*, JSC::ProtoCallFrame*) + 49
		frame #27: 0x093b38de JavaScriptCore`JSC::Interpreter::execute(JSC::ProgramExecutable*, JSC::ExecState*, JSC::JSObject*) + 9582
		frame #28: 0x0920d36a JavaScriptCore`JSC::evaluate(JSC::ExecState*, JSC::SourceCode const&, JSC::JSValue, JSC::JSValue*) + 506
		frame #29: 0x055a4ec5 WebCore`WebCore::ScriptController::evaluateInWorld(WebCore::ScriptSourceCode const&, WebCore::DOMWrapperWorld&) + 277
		frame #30: 0x055a51bb WebCore`WebCore::ScriptController::evaluate(WebCore::ScriptSourceCode const&) + 43
		frame #31: 0x055ab749 WebCore`WebCore::ScriptElement::executeScript(WebCore::ScriptSourceCode const&) + 217
		frame #32: 0x055ab89c WebCore`WebCore::ScriptElement::execute(WebCore::CachedScript*) + 92
		frame #33: 0x055b0793 WebCore`WebCore::ScriptRunner::timerFired(WebCore::Timer<WebCore::ScriptRunner>&) + 499
		frame #34: 0x055b18c9 WebCore`std::__1::__function::__func<std::__1::__bind<void (WebCore::ScriptRunner::*&)(WebCore::Timer<WebCore::ScriptRunner>&), WebCore::ScriptRunner*&, std::__1::reference_wrapper<WebCore::Timer<WebCore::ScriptRunner> > >, std::__1::allocator<std::__1::__bind<void (WebCore::ScriptRunner::*&)(WebCore::Timer<WebCore::ScriptRunner>&), WebCore::ScriptRunner*&, std::__1::reference_wrapper<WebCore::Timer<WebCore::ScriptRunner> > > >, void ()>::operator()() + 41
		frame #35: 0x055b177f WebCore`WebCore::Timer<WebCore::ScriptRunner>::fired() + 31
		frame #36: 0x0579727e WebCore`WebCore::ThreadTimers::sharedTimerFiredInternal() + 190
		frame #37: 0x05797116 WebCore`WebCore::ThreadTimers::sharedTimerFired() + 22
		frame #38: 0x055ff81b WebCore`WebCore::timerFired(__CFRunLoopTimer*, void*) + 27
		frame #39: 0x0082a866 CoreFoundation`__CFRUNLOOP_IS_CALLING_OUT_TO_A_TIMER_CALLBACK_FUNCTION__ + 22
		frame #40: 0x0082a1ed CoreFoundation`__CFRunLoopDoTimer + 1309
		frame #41: 0x007e854a CoreFoundation`__CFRunLoopRun + 2090
		frame #42: 0x007e7a5b CoreFoundation`CFRunLoopRunSpecific + 443
		frame #43: 0x007e788b CoreFoundation`CFRunLoopRunInMode + 123
		frame #44: 0x05817360 WebCore`RunWebThread(void*) + 608
		frame #45: 0x02f76e13 libsystem_pthread.dylib`_pthread_body + 138
		frame #46: 0x02f76d89 libsystem_pthread.dylib`_pthread_start + 162
		frame #47: 0x02f74e52 libsystem_pthread.dylib`thread_start + 34

# Workarounds #1
Instead of reload the UIWebView, destroy it comletely, create a new one and load on the newlu create webView.

# Workarounds #2
Use WKWebView instead, memory usage is much lower, does not have leak and almost bug free, at least does not cause this app to crash. 
