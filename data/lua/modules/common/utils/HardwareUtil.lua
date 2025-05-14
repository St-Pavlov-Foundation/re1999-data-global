module("modules.common.utils.HardwareUtil", package.seeall)

local var_0_0 = _M
local var_0_1
local var_0_2 = "none"

function var_0_0.getPerformanceGrade()
	if not var_0_1 then
		local var_1_0 = UnityEngine.SystemInfo.deviceModel
		local var_1_1 = BootNativeUtil.getCpuName()
		local var_1_2 = UnityEngine.SystemInfo.graphicsDeviceName
		local var_1_3 = UnityEngine.SystemInfo.systemMemorySize

		logNormal("DeviceName: " .. (var_1_0 or "nil") .. "\nCPU: " .. (var_1_1 or "nil") .. "\n" .. "GPU: " .. (var_1_2 or "nil") .. "\n" .. "Memory: " .. (var_1_3 or "nil"))

		local var_1_4 = CommonConfig.instance:getCPULevel(var_1_1 or "")
		local var_1_5 = CommonConfig.instance:getGPULevel(var_1_2 or "")

		var_0_1 = ModuleEnum.Performance.High

		if var_1_4 ~= ModuleEnum.Performance.Undefine then
			var_0_1 = var_1_4
			var_0_2 = "cpu"
		elseif var_1_5 ~= ModuleEnum.Performance.Undefine then
			var_0_1 = var_1_5
			var_0_2 = "gpu"
		elseif var_1_3 then
			if BootNativeUtil.isIOS() then
				if var_1_3 <= 2048 then
					var_0_1 = ModuleEnum.Performance.Low
				elseif var_1_3 <= 4096 then
					var_0_1 = ModuleEnum.Performance.Middle
				end
			elseif var_1_3 <= 3072 then
				var_0_1 = ModuleEnum.Performance.Low
			elseif var_1_3 <= 5120 then
				var_0_1 = ModuleEnum.Performance.Middle
			end

			var_0_2 = "memory"
		end
	end

	return var_0_1, var_0_2
end

return var_0_0
