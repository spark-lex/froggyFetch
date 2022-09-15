local logService     = game:GetService("LogService");
local soundService   = game:GetService("SoundService");
local userInput      = game:GetService("UserInputService");
local videoCapture   = game:GetService("VideoCaptureService");
local getHttpResults = logService.GetHttpResultHistory;

local froggyFetch = {}; do
    local gsub, format, char       = string.gsub, string.format, string.char;
    local tostring, find, tonumber = tostring, string.find, tonumber;
    
    function froggyFetch.decodeHex(str)
        return(gsub(str, "%%(%x%x)", function(h)
            return char(tonumber(h, 16));
        end))
    end;

    function froggyFetch.recursive(t)
        for i = 1, #t do
            local v = t[i];
            if v["URL"] and find(v["URL"], "info=") then
                return v.URL;
            end
        end
    end

    function froggyFetch.merge(a, b)
        for k, v in next, b do
            a[k] = v;
        end

        return a;    
    end

    function froggyFetch.get(self)
        local t = {};
        local r = self.decodeHex(self.results); do
            local c = r:gsub(".*&cpu=", ""):gsub("&.*", ""):gsub("CPU.*", "");
            local g = r:gsub(".*&gpu_info=", ""):gsub("&.*", "");
            local gd = r:gsub(".*&gpu_driver=", ""):gsub("&.*", ""):gsub("%..*", ".dll");
            local dS = r:gsub(".*&deviceShadingLanguage=", ""):gsub("&.*", "");
            local r = r:gsub(".*&memMB=", ""):gsub("&.*", ""):gsub(".*%/", "");
            local _, dev = pcall(soundService.GetOutputDevices, soundService)
            local _, cam = pcall(videoCapture.GetCameraDevices, videoCapture)
            local _, platform = pcall(userInput.GetPlatform, userInput)

            return self.merge(t, {
                ["CPU"] = c; ["GPU"] = g; ["RAM"] = r;
                ["GPU_DRIVER"] = gd; ["DEVICE_SHADING_LANG"] = dS;
                ["CURRENT_PLATFORM"] = tostring(platform and platform.Name or "Unknown");
                ["SOUND_OUTPUT_DEVICES"] = dev;
                ["CAMERA_ACTIVE"] = tostring(videoCapture.Active) or "false";
                ["CAMERA_DEVICES"] = cam;
            })
        end
    end

    froggyFetch.results = froggyFetch.recursive(getHttpResults(logService));
end

return froggyFetch
