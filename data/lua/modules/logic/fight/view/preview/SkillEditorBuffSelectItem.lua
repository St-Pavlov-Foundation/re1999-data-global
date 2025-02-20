module("modules.logic.fight.view.preview.SkillEditorBuffSelectItem", package.seeall)

slot0 = class("SkillEditorBuffSelectItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._text = gohelper.findChildText(slot1, "Text")
	slot0._text1 = gohelper.findChildText(slot1, "imgSelect/Text")
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot1)
	slot0._selectGO = gohelper.findChild(slot1, "imgSelect")
	slot0._textAddLayer1 = nil
	slot0._textAddLayer10 = nil
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickListener(slot0._onClickThis, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()

	if slot0._clickLayer1 then
		slot0._clickLayer1:RemoveClickListener()
		slot0._clickLayer10:RemoveClickListener()
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot2 = slot1.co
	slot0._text.text = slot2.id .. "\n" .. slot2.name
	slot0._text1.text = slot2.id .. "\n" .. slot2.name
	slot4 = slot0:_getEntityBuffMO(SkillEditorBuffSelectModel.instance.attacker, slot2.id) ~= nil

	gohelper.setActive(slot0._text.gameObject, not slot4)
	gohelper.setActive(slot0._selectGO, slot4)

	slot0._canShowLayer = false

	if slot4 then
		for slot8, slot9 in ipairs(lua_fight_buff_layer_effect.configList) do
			if slot9.id == slot2.id then
				slot0._canShowLayer = true

				break
			end
		end
	end

	if slot0._canShowLayer and not slot0._textAddLayer1 then
		slot0._textAddLayer1 = gohelper.findChildText(slot0.go, "layer1")
		slot0._textAddLayer10 = gohelper.findChildText(slot0.go, "layer10")
		slot0._textAddLayer1.text = "<color=white>+1层</color>"
		slot0._textAddLayer10.text = "<color=white>+10层</color>"
		slot0._textAddLayer1.raycastTarget = true
		slot0._textAddLayer10.raycastTarget = true
		slot0._clickLayer1 = gohelper.getClick(gohelper.cloneInPlace(slot0._text.gameObject, "layer1"))
		slot0._clickLayer10 = gohelper.getClick(gohelper.cloneInPlace(slot0._text.gameObject, "layer10"))

		slot0._clickLayer1:AddClickListener(slot0._onClickAddLayer1, slot0)
		slot0._clickLayer10:AddClickListener(slot0._onClickAddLayer10, slot0)
		recthelper.setAnchor(slot0._textAddLayer1.transform, 100, 25)
		recthelper.setAnchor(slot0._textAddLayer10.transform, 100, -10)
	end

	if slot0._textAddLayer1 then
		gohelper.setActive(slot0._textAddLayer1.gameObject, slot0._canShowLayer)
		gohelper.setActive(slot0._textAddLayer10.gameObject, slot0._canShowLayer)
	end
end

function slot0._onClickAddLayer1(slot0)
	slot2.layer = slot0:_getEntityBuffMO(SkillEditorBuffSelectModel.instance.attacker, slot0._mo.co.id).layer and slot2.layer + 1 or 1

	FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, slot1.id, FightEnum.EffectType.BUFFUPDATE, slot0._mo.co.id, slot2.uid, 0)
	FightController.instance:dispatchEvent(FightEvent.SkillEditorRefreshBuff, slot0._mo.co.id)
end

function slot0._onClickAddLayer10(slot0)
	slot2.layer = slot0:_getEntityBuffMO(SkillEditorBuffSelectModel.instance.attacker, slot0._mo.co.id).layer and slot2.layer + 10 or 10

	FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, slot1.id, FightEnum.EffectType.BUFFUPDATE, slot0._mo.co.id, slot2.uid, 0)
	FightController.instance:dispatchEvent(FightEvent.SkillEditorRefreshBuff, slot0._mo.co.id)
end

function slot0._onClickThis(slot0)
	if slot0:_getEntityBuffMO(SkillEditorBuffSelectModel.instance.attacker, slot0._mo.co.id) == nil then
		slot4 = FightBuffMO.New()

		slot4:init({
			buffId = slot2.id,
			duration = 1,
			count = 1,
			uid = SkillEditorBuffSelectView.genBuffUid()
		}, slot1.id)
		slot1:getMO():addBuff(slot4)
		slot1.buff:addBuff(slot4)

		if SkillEditorBuffSelectView._show_frame then
			FightController.instance:dispatchEvent(FightEvent.OnEditorPlayBuffStart)
		end
	else
		slot1:getMO():delBuff(slot3.uid)
		slot1.buff:delBuff(slot3.uid)
	end

	if slot2.typeId == 5001 then
		slot1.nameUI:setShield(math.floor(slot1.nameUI:getHp() * 0.1 + 0.5))
	end

	FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate)
	FightController.instance:dispatchEvent(FightEvent.SkillEditorRefreshBuff, slot2.id)
	slot0:onUpdateMO(slot0._mo)
end

function slot0._getEntityBuffMO(slot0, slot1, slot2)
	for slot7, slot8 in pairs(slot1:getMO():getBuffDic()) do
		if slot8.buffId == slot2 then
			return slot8
		end
	end

	return nil
end

return slot0
