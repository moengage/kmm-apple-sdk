#if targetEnvironment(simulator)
#if arch(x86_64)
#error("""
Unsupported architecture for simulatorhttps://developers.moengage.com/hc/en-us/articles/43255588673684-Configuring-Project-for-Architecture-Compatibility#h_01K9VWV2EDFWNSHQK02R7CP7WT
""")
#endif
#endif