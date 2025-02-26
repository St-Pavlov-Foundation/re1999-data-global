module("modules.common.utils.HardwareUtil", package.seeall)

slot0 = _M
slot1 = nil
slot2 = "none"

function slot0.getPerformanceGrade()
	if not uv0 then
		slot1 = BootNativeUtil.getCpuName()
		slot2 = UnityEngine.SystemInfo.graphicsDeviceName

		logNormal("DeviceName: " .. (UnityEngine.SystemInfo.deviceModel or "nil") .. "\nCPU: " .. (slot1 or "nil") .. "\n" .. "GPU: " .. (slot2 or "nil") .. "\n" .. "Memory: " .. (UnityEngine.SystemInfo.systemMemorySize or "nil"))

		slot4 = CommonConfig.instance
		slot5 = slot4
		slot5 = CommonConfig.instance:getGPULevel(slot2 or "")
		uv0 = ModuleEnum.Performance.High

		if slot4.getCPULevel(slot5, slot1 or "") ~= ModuleEnum.Performance.Undefine then
			uv0 = slot4
			uv1 = "cpu"
		elseif slot5 ~= ModuleEnum.Performance.Undefine then
			uv0 = slot5
			uv1 = "gpu"
		elseif slot3 then
			if BootNativeUtil.isIOS() then
				if slot3 <= 2048 then
					uv0 = ModuleEnum.Performance.Low
				elseif slot3 <= 4096 then
					uv0 = ModuleEnum.Performance.Middle
				end
			elseif slot3 <= 3072 then
				uv0 = ModuleEnum.Performance.Low
			elseif slot3 <= 5120 then
				uv0 = ModuleEnum.Performance.Middle
			end

			uv1 = "memory"
		end
	end

	return uv0, uv1
end

return slot0
