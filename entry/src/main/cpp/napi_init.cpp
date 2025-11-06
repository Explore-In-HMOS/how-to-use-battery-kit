#include "napi/native_api.h"
#include "BasicServicesKit/ohbattery_info.h"
#include <cstdint>


// An example usage with Native C
// App or widget doesn't use this file

static napi_value NAPI_Global_GetCapacity(napi_env env, napi_callback_info info)
{
    int32_t value0 = OH_BatteryInfo_GetCapacity();

    napi_value sum;
    napi_create_double(env, value0, &sum);
    
    return sum;
}

EXTERN_C_START
static napi_value Init(napi_env env, napi_value exports) {
    napi_property_descriptor desc[] = {
        {"GetCapacity", nullptr, NAPI_Global_GetCapacity, nullptr, nullptr, nullptr, napi_default, nullptr }
    };
    napi_define_properties(env, exports, sizeof(desc) / sizeof(desc[0]), desc);
    return exports;
}
EXTERN_C_END

static napi_module demoModule = {
    .nm_version = 1,
    .nm_flags = 0,
    .nm_filename = nullptr,
    .nm_register_func = Init,
    .nm_modname = "entry",
    .nm_priv = ((void*)0),
    .reserved = { 0 },
};

extern "C" __attribute__((constructor)) void RegisterEntryModule(void)
{
    napi_module_register(&demoModule);
}
