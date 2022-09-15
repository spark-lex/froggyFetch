<div align = "center">

# :frog: froggyFetch

A simple Luau script that can fetch your PC specifications.

</div>

## Usage:
```lua
local froggyFetch: table = loadfile("froggyFetch.lua");
local hardware:    table = assert(froggyFetch:get(), "failed to acquire hardware information"); --: Now you have a table with hardware information, example of table:
--[[:
    WARNING: Sometimes froggyFetch will fail, make sure to always include sanity checks;
    {
        ["CPU"] = ("Intel(R) Core(TM) i7-1280P"); ["GPU"] = ("Intel(R) UHD Graphics 680");
        ["RAM"] = ("16228"); ["GPU_DRIVER"] = ("nvldumd"); ["DEVICE_SHADING_LANG"] = ("D3D11");
        ["CURRENT_PLATFORM"] = ("Windows"); ["SOUND_OUTPUT_DEVICES"] = {"Headphones (Galaxy Buds Live (FF61) Stereo)"};
        ["CAMERA_ACTIVE"] = ("false"); ["CAMERA_DEVICES"] = {};
    };
:]]--

print("My CPU is:", hardware["CPU"] or ("Unknown"))
```
