module("modules.logic.gm.model.GMMinusModel", package.seeall)

slot0 = class("GMMinusModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._firstLoginDataDict = {}
end

function slot0.setFirstLogin(slot0, slot1, slot2)
	slot0._firstLoginDataDict[slot1] = slot2
end

function slot0.getFirstLogin(slot0, slot1, slot2)
	return slot0._firstLoginDataDict[slot1] == nil and slot2 or slot3
end

slot1 = {}
slot2 = {}

function slot0.setConst(slot0, slot1, slot2)
	if uv0[slot1] then
		return
	end

	uv0[slot1] = true
	uv1[slot1] = slot2
end

function slot0.getConst(slot0, slot1, slot2)
	if not uv0[slot1] then
		return slot2
	end

	return uv1[slot1]
end

function slot0.setToPlayer(slot0, slot1, slot2)
	if not PlayerModel.instance:getMyUserId() or slot3 == 0 then
		return
	end

	slot0:setToUnity(slot1 .. "#" .. tostring(slot3), slot2)
end

function slot0.getFromPlayer(slot0, slot1, slot2)
	if not PlayerModel.instance:getMyUserId() or slot3 == 0 then
		return slot2
	end

	return slot0:getFromUnity(slot1 .. "#" .. tostring(slot3), slot2)
end

function slot0.setToUnity(slot0, slot1, slot2)
	PlayerPrefsHelper._set(slot1, slot2)
end

function slot0.getFromUnity(slot0, slot1, slot2)
	assert(slot2 ~= nil)

	return PlayerPrefsHelper._get(slot1, slot2, type(slot2) == "number")
end

function slot0.addBtnGM(slot0, slot1)
	slot1._btngm11235 = gohelper.findChildButtonWithAudio(GMController.instance:getGMNode("mainview", slot1.viewGO), "#btn_gm")

	return slot1._btngm11235
end

function slot3(slot0)
	slot3 = "GM_" .. slot0.class.__cname

	assert(ViewName[slot3], "please add customFunc when call btnGM_AddClickListener!!viewName not found: " .. slot3)
	ViewMgr.instance:openView(slot3)
end

function slot0.btnGM_AddClickListener(slot0, slot1, slot2)
	slot1._btngm11235:AddClickListener(slot2 or uv0, slot1)
end

function slot0.btnGM_RemoveClickListener(slot0, slot1)
	slot1._btngm11235:RemoveClickListener()
end

slot4 = 20

function slot5(slot0, slot1)
	return string.format("GM_%s_%s", slot0.__cname, slot1)
end

function slot0.saveOriginalFunc(slot0, slot1, slot2)
	assert(type(slot2) == "string")

	if slot1[slot2] == nil then
		slot4 = slot1
		slot5 = uv0

		while slot4.super and slot3 == nil do
			if slot5 <= 0 then
				logError("stack overflow >= " .. tostring(uv0))

				break
			end

			slot3 = slot4[slot2]
			slot4 = slot4.super
			slot5 = slot5 - 1
		end
	end

	assert(type(slot3) == "function", "type(func)=" .. type(slot3) .. " funcName=" .. slot2)
	slot0:setConst(uv1(slot1, slot2), slot3)
end

function slot0.loadOriginalFunc(slot0, slot1, slot2)
	if not slot0:getConst(uv0(slot1, slot2), nil) then
		slot5 = slot1.super
		slot6 = uv1

		while slot5 and slot4 == nil do
			if slot6 <= 0 then
				logError("stack overflow >= " .. tostring(uv1))

				break
			end

			slot4 = slot0:getConst(uv0(slot5, slot2), nil) or slot5[slot2]
			slot5 = slot5.super
			slot6 = slot6 - 1
		end
	end

	return slot4 or function ()
		assert(false, string.format("undefine behaviour: '%s:%s'", uv0.__cname, uv1))
	end
end

function slot0.callOriginalSelfFunc(slot0, slot1, slot2, ...)
	return slot0:loadOriginalFunc(slot1.class, slot2)(slot1, ...)
end

function slot0.callOriginalStaticFunc(slot0, slot1, slot2, ...)
	return slot0:loadOriginalFunc(slot1, slot2)(...)
end

slot0.instance = slot0.New()

return slot0
