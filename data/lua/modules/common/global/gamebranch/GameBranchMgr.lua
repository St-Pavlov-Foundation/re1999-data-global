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

	if slot0:getMajorVer() == slot1 then
		return math.max(0, slot2 or 0) <= slot0:getMinorVer()
	end

	return slot1 < slot3
end

function slot3.isOnVer(slot0, slot1, slot2)
	if not slot1 then
		return false
	end

	return slot0:getMajorVer() == slot1 and slot0:getMinorVer() == math.max(0, slot2 or 0)
end

function slot3.isOnPreVer(slot0, slot1, slot2)
	if not slot1 then
		return false
	end

	if slot0:getMajorVer() == slot1 then
		return slot0:getMinorVer() <= math.max(0, slot2 or 0)
	end

	return slot3 < slot1
end

function slot3.isV1a0(slot0)
	return slot0:isVer(1, 0)
end

function slot3.isV1a1(slot0)
	return slot0:isVer(1, 1)
end

function slot3.isV1a2(slot0)
	return slot0:isVer(1, 2)
end

function slot3.isV1a3(slot0)
	return slot0:isVer(1, 3)
end

function slot3.isV1a4(slot0)
	return slot0:isVer(1, 4)
end

function slot3.isV1a5(slot0)
	return slot0:isVer(1, 5)
end

function slot3.isV1a6(slot0)
	return slot0:isVer(1, 6)
end

function slot3.isV1a7(slot0)
	return slot0:isVer(1, 7)
end

function slot3.isV1a8(slot0)
	return slot0:isVer(1, 8)
end

function slot3.isV1a9(slot0)
	return slot0:isVer(1, 9)
end

function slot3.isV2a0(slot0)
	return slot0:isVer(2, 0)
end

function slot3.isV2a1(slot0)
	return slot0:isVer(2, 1)
end

function slot3.isV2a2(slot0)
	return slot0:isVer(2, 2)
end

function slot3.isV2a3(slot0)
	return slot0:isVer(2, 3)
end

function slot3.isV2a4(slot0)
	return slot0:isVer(2, 4)
end

function slot3.isV2a5(slot0)
	return slot0:isVer(2, 5)
end

function slot3.isV2a6(slot0)
	return slot0:isVer(2, 6)
end

function slot3.isV2a7(slot0)
	return slot0:isVer(2, 7)
end

function slot3.isV2a8(slot0)
	return slot0:isVer(2, 8)
end

function slot3.isV2a9(slot0)
	return slot0:isVer(2, 9)
end

function slot3.isV3a0(slot0)
	return slot0:isVer(3, 0)
end

function slot3.isV3a1(slot0)
	return slot0:isVer(3, 1)
end

function slot3.isV3a2(slot0)
	return slot0:isVer(3, 2)
end

function slot3.isV3a3(slot0)
	return slot0:isVer(3, 3)
end

function slot3.isV3a4(slot0)
	return slot0:isVer(3, 4)
end

function slot3.isV3a5(slot0)
	return slot0:isVer(3, 5)
end

function slot3.isV3a6(slot0)
	return slot0:isVer(3, 6)
end

function slot3.isV3a7(slot0)
	return slot0:isVer(3, 7)
end

function slot3.isV3a8(slot0)
	return slot0:isVer(3, 8)
end

function slot3.isV3a9(slot0)
	return slot0:isVer(3, 9)
end

function slot3.isV4a0(slot0)
	return slot0:isVer(4, 0)
end

function slot3.isV4a1(slot0)
	return slot0:isVer(4, 1)
end

function slot3.isV4a2(slot0)
	return slot0:isVer(4, 2)
end

function slot3.isV4a3(slot0)
	return slot0:isVer(4, 3)
end

function slot3.isV4a4(slot0)
	return slot0:isVer(4, 4)
end

function slot3.isV4a5(slot0)
	return slot0:isVer(4, 5)
end

function slot3.isV4a6(slot0)
	return slot0:isVer(4, 6)
end

function slot3.isV4a7(slot0)
	return slot0:isVer(4, 7)
end

function slot3.isV4a8(slot0)
	return slot0:isVer(4, 8)
end

function slot3.isV4a9(slot0)
	return slot0:isVer(4, 9)
end

function slot3.isV5a0(slot0)
	return slot0:isVer(5, 0)
end

function slot3.isV5a1(slot0)
	return slot0:isVer(5, 1)
end

function slot3.isV5a2(slot0)
	return slot0:isVer(5, 2)
end

function slot3.isV5a3(slot0)
	return slot0:isVer(5, 3)
end

function slot3.isV5a4(slot0)
	return slot0:isVer(5, 4)
end

function slot3.isV5a5(slot0)
	return slot0:isVer(5, 5)
end

function slot3.isV5a6(slot0)
	return slot0:isVer(5, 6)
end

function slot3.isV5a7(slot0)
	return slot0:isVer(5, 7)
end

function slot3.isV5a8(slot0)
	return slot0:isVer(5, 8)
end

function slot3.isV5a9(slot0)
	return slot0:isVer(5, 9)
end

function slot3.isV6a0(slot0)
	return slot0:isVer(6, 0)
end

function slot3.isV6a1(slot0)
	return slot0:isVer(6, 1)
end

function slot3.isV6a2(slot0)
	return slot0:isVer(6, 2)
end

function slot3.isV6a3(slot0)
	return slot0:isVer(6, 3)
end

function slot3.isV6a4(slot0)
	return slot0:isVer(6, 4)
end

function slot3.isV6a5(slot0)
	return slot0:isVer(6, 5)
end

function slot3.isV6a6(slot0)
	return slot0:isVer(6, 6)
end

function slot3.isV6a7(slot0)
	return slot0:isVer(6, 7)
end

function slot3.isV6a8(slot0)
	return slot0:isVer(6, 8)
end

function slot3.isV6a9(slot0)
	return slot0:isVer(6, 9)
end

function slot3.isV7a0(slot0)
	return slot0:isVer(7, 0)
end

function slot3.isV7a1(slot0)
	return slot0:isVer(7, 1)
end

function slot3.isV7a2(slot0)
	return slot0:isVer(7, 2)
end

function slot3.isV7a3(slot0)
	return slot0:isVer(7, 3)
end

function slot3.isV7a4(slot0)
	return slot0:isVer(7, 4)
end

function slot3.isV7a5(slot0)
	return slot0:isVer(7, 5)
end

function slot3.isV7a6(slot0)
	return slot0:isVer(7, 6)
end

function slot3.isV7a7(slot0)
	return slot0:isVer(7, 7)
end

function slot3.isV7a8(slot0)
	return slot0:isVer(7, 8)
end

function slot3.isV7a9(slot0)
	return slot0:isVer(7, 9)
end

function slot3.isV8a0(slot0)
	return slot0:isVer(8, 0)
end

function slot3.isV8a1(slot0)
	return slot0:isVer(8, 1)
end

function slot3.isV8a2(slot0)
	return slot0:isVer(8, 2)
end

function slot3.isV8a3(slot0)
	return slot0:isVer(8, 3)
end

function slot3.isV8a4(slot0)
	return slot0:isVer(8, 4)
end

function slot3.isV8a5(slot0)
	return slot0:isVer(8, 5)
end

function slot3.isV8a6(slot0)
	return slot0:isVer(8, 6)
end

function slot3.isV8a7(slot0)
	return slot0:isVer(8, 7)
end

function slot3.isV8a8(slot0)
	return slot0:isVer(8, 8)
end

function slot3.isV8a9(slot0)
	return slot0:isVer(8, 9)
end

function slot3.isV9a0(slot0)
	return slot0:isVer(9, 0)
end

function slot3.isV9a1(slot0)
	return slot0:isVer(9, 1)
end

function slot3.isV9a2(slot0)
	return slot0:isVer(9, 2)
end

function slot3.isV9a3(slot0)
	return slot0:isVer(9, 3)
end

function slot3.isV9a4(slot0)
	return slot0:isVer(9, 4)
end

function slot3.isV9a5(slot0)
	return slot0:isVer(9, 5)
end

function slot3.isV9a6(slot0)
	return slot0:isVer(9, 6)
end

function slot3.isV9a7(slot0)
	return slot0:isVer(9, 7)
end

function slot3.isV9a8(slot0)
	return slot0:isVer(9, 8)
end

function slot3.isV9a9(slot0)
	return slot0:isVer(9, 9)
end

slot3.instance = slot3.New()

return slot3
