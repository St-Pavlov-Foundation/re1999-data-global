module("modules.common.global.gamebranch.GameBranchMgr", package.seeall)

slot0 = string.format
slot1 = _G.tonumber
slot2 = _G.assert
slot3 = class("GameBranchMgr")
slot4 = false

function slot5(slot0)
	slot1 = "AudioEnum%s_%s"
	slot0.V = 1
	slot0.A = 5

	while slot2 < math.huge do
		while slot3 < 10 do
			if not _G[uv0(slot1, slot2, slot3)] then
				slot6 = slot3

				while slot3 < 10 do
					if _G[uv0(slot1, slot2, slot3 + 1)] then
						break
					end
				end

				if slot6 == 0 and not slot5 then
					return
				end

				if slot3 >= 10 then
					break
				end
			end

			if slot3 == 0 and not slot5 then
				return
			elseif not slot5 then
				break
			end

			slot0.V = slot2
			slot0.A = slot3
			slot3 = slot3 + 1
		end

		slot2 = slot2 + 1
		slot3 = 0
	end
end

function slot3.ctor(slot0)
	if not uv0 then
		uv0 = {}

		uv1(uv0)
	end

	slot0._versionInfo = uv0
end

function slot3.init(slot0, slot1, slot2)
	if uv1(slot1 or uv0.V) then
		uv2(uv1(slot1) >= 1)

		slot2 = slot2 or uv0.A or 0
	else
		slot1 = uv0.V
		slot2 = uv0.A
	end

	slot0:_init(slot1, slot2)
end

function slot3._init(slot0, slot1, slot2)
	slot0._versionInfo = {
		V = slot1,
		A = slot2
	}

	if isDebugBuild then
		logNormal(uv0("<color=#FFFF00>[GameBranchMgr] 当前版本: %s</color>", slot0:VHyphenA()))
	end
end

function slot3.inject(slot0)
	slot0:_module_views(slot0:versionFullInfo())
end

function slot3._module_views(slot0, slot1)
	ActivityController.instance:onModuleViews(slot1, require("modules.setting.module_views"))
end

function slot3.lastVersionInfo(slot0)
	return slot0:getLastVersionInfo(slot0._versionInfo.V, slot0._versionInfo.A)
end

function slot3.versionFullInfo(slot0)
	slot1 = slot0._versionInfo
	slot2 = slot0:lastVersionInfo()

	return {
		curV = slot1.V,
		curA = slot1.A,
		lastV = slot2.V,
		lastA = slot2.A
	}
end

function slot3.getLastVersionInfo(slot0, slot1, slot2)
	if slot2 <= 0 then
		slot2 = 9
		slot1 = slot1 - 1
	end

	if slot1 <= 0 then
		slot1 = 1
		slot2 = 0
	end

	return {
		V = slot1,
		A = slot2
	}
end

function slot3.getMajorVer(slot0)
	return slot0._versionInfo.V
end

function slot3.getMinorVer(slot0)
	return slot0._versionInfo.A
end

function slot3.VHyphenA(slot0)
	return slot0:getMajorVer() .. "-" .. slot0:getMinorVer()
end

function slot3.getVxax(slot0)
	return "V" .. slot0:getMajorVer() .. "a" .. slot0:getMinorVer()
end

function slot3.getvxax(slot0)
	return "v" .. slot0:getMajorVer() .. "a" .. slot0:getMinorVer()
end

function slot3.getVxax_(slot0)
	return slot0:getVxax() .. "_"
end

function slot3.getvxax_(slot0)
	return slot0:getvxax() .. "_"
end

function slot3.getV_a(slot0)
	return slot0:getMajorVer() .. "_" .. slot0:getMinorVer()
end

function slot3.getv_a(slot0)
	return slot0:getV_a()
end

function slot3.V_a(slot0, slot1, slot2)
	return (slot1 or "") .. slot0:getV_a() .. (slot2 or "")
end

function slot3.v_a(slot0, slot1, slot2)
	return slot0:V_a(slot1, slot2)
end

function slot3.Vxax(slot0, slot1, slot2)
	return (slot1 or "") .. slot0:getVxax() .. (slot2 or "")
end

function slot3.vxax(slot0, slot1, slot2)
	return (slot1 or "") .. slot0:getvxax() .. (slot2 or "")
end

function slot3.Vxax_(slot0, slot1)
	return slot0:getVxax_() .. slot1
end

function slot3.vxax_(slot0, slot1)
	return slot0:getvxax_() .. slot1
end

function slot3.Vxax_ActId(slot0, slot1, slot2)
	return ActivityEnum.Activity[slot0:Vxax_(slot1)] or slot2
end

function slot3.Vxax_ViewName(slot0, slot1, slot2)
	return _G.ViewName[slot0:Vxax_(slot1)] or slot2
end

function slot3.isVer(slot0, slot1, slot2)
	if not slot1 then
		return false
	end

	if slot1 == slot0:getMajorVer() then
		return slot0:getMinorVer() <= math.max(0, slot2 or 0)
	end

	return slot3 < slot1
end

slot3.instance = slot3.New()

return slot3
