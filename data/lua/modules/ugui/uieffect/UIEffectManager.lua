module("modules.ugui.uieffect.UIEffectManager", package.seeall)

slot0 = class("UIEffectManager")

function slot0.ctor(slot0)
	slot0._effectDic = {}
end

function slot0.addEffect(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	if gohelper.isNil(slot1) then
		return
	end

	slot0._loadcallback = slot7
	slot0._callbackTarget = slot8

	if not slot3 or not slot4 then
		logError(string.format("addEffect rt size error rtWidth:%s,rtHeight:%s", slot3, slot4))

		return
	end

	if MonoHelper.addNoUpdateLuaComOnceToGo(slot1, UIEffectUnit) then
		slot9:Refresh(slot1, slot2, slot3, slot4, slot5, slot6)
	end

	AudioEffectMgr.instance:playAudioByEffectPath(slot2)
end

function slot0._getEffect(slot0, slot1, slot2, slot3, slot4)
	if not slot0._effectDic[slot1] then
		slot0._effectDic[slot1] = {}
	end

	if not slot0._effectDic[slot1][string.format("%s_%s", slot2, slot3)] then
		slot6 = UIEffectLoader.New()

		slot6:Init(slot1, slot2, slot3)

		slot0._effectDic[slot1][slot5] = slot6
	end

	slot6:getEffect(slot4, slot0._loadcallback, slot0._callbackTarget)
end

function slot0.getEffectGo(slot0, slot1, slot2, slot3)
	if not slot0._effectDic[slot1] then
		return
	end

	return slot0._effectDic[slot1][string.format("%s_%s", slot2, slot3)]:getEffectGo()
end

function slot0._putEffect(slot0, slot1, slot2, slot3)
	if not slot0._effectDic[slot1] then
		return
	end

	if slot0._effectDic[slot1][string.format("%s_%s", slot2, slot3)] then
		slot5:ReduceRef()
	end
end

function slot0._delEffectLoader(slot0, slot1, slot2, slot3)
	if not slot0._effectDic[slot1] then
		return
	end

	slot0._effectDic[slot1][string.format("%s_%s", slot2, slot3)] = nil
end

function slot0.getUIEffect(slot0, slot1, slot2)
	if not slot1 then
		return nil
	end

	if slot1:GetComponent(typeof(TMPro.TextMeshProUGUI)) then
		logError("TextMeshPro 不能和 UIEffect 一起使用")

		return nil
	end

	return gohelper.onceAddComponent(slot1, slot2)
end

slot0.instance = slot0.New()

return slot0
