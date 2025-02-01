module("modules.logic.rouge.common.comp.RougeLvComp", package.seeall)

slot0 = class("RougeLvComp", UserDataDispose)
slot1 = 3

function slot0.Get(slot0)
	slot1 = uv0.New()

	slot1:init(slot0)

	return slot1
end

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1

	slot0:_editableInitView()
end

function slot0._editableInitView(slot0)
	slot0._imageTypeIcon = gohelper.findChildImage(slot0.go, "Root/#image_TypeIcon")
	slot0._txttalent = gohelper.findChildText(slot0.go, "Root/#txt_talent")
	slot0._txttotal = gohelper.findChildText(slot0.go, "Root/#txt_total")
	slot0._txtLv = gohelper.findChildText(slot0.go, "Root/#txt_Lv")
	slot0._txtTypeName = gohelper.findChildText(slot0.go, "Root/#txt_TypeName")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.go, "Root/#btn_click")
	slot0._goeffect = gohelper.findChild(slot0.go, "Root/effect")
	slot0._gomagic = gohelper.findChild(slot0.go, "Root/magic")
	slot0._goeffectget = gohelper.findChild(slot0.go, "Root/effect_get")
	slot0._costTalentPoint = tonumber(RougeConfig1.instance:getConstValueByID(RougeEnum.Const.TalentCost))

	slot0:addEvents()
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeInfoTeamValues, slot0.refreshLV, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeInfo, slot0.refreshLV, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeInfoPower, slot0.refreshPower, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeInfoTalentPoint, slot0.onUpdateTalentPoint, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinishCallBack, slot0)
end

function slot0.onOpen(slot0)
	slot0.rougeInfo = RougeModel.instance:getRougeInfo()

	if not slot0.rougeInfo or not slot0.rougeInfo.season then
		return
	end

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshStyle()
	slot0:refreshLV()
	slot0:refreshPower()
	slot0:refreshTalentEffect()
end

function slot0.refreshTalentEffect(slot0)
	if slot0._costTalentPoint <= RougeModel.instance:getRougeInfo().talentPoint then
		slot4 = slot1.talentInfo
		slot5 = #slot4

		if slot4[slot5 - 1].isActive == 1 or slot4[slot5].isActive == 1 then
			slot3 = false
		end
	end

	gohelper.setActive(slot0._goeffect, slot3)
end

function slot0.refreshStyle(slot0)
	slot3 = lua_rouge_style.configDict[slot0.rougeInfo.season][slot0.rougeInfo.style]

	UISpriteSetMgr.instance:setRouge2Sprite(slot0._imageTypeIcon, string.format("%s_light", slot3.icon))

	slot0._txtTypeName.text = slot3.name
end

function slot0.refreshLV(slot0)
	slot0._txtLv.text = "Lv." .. slot0.rougeInfo.teamLevel
end

function slot0.refreshPower(slot0)
	slot1 = slot0.rougeInfo

	if not slot0.prePower then
		slot0._txttalent.text = slot1.power
		slot0.prePower = slot1.power
	elseif slot0.prePower ~= slot1.power then
		slot0:killTween()
		gohelper.setActive(slot0._gomagic, false)
		gohelper.setActive(slot0._gomagic, true)

		slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(slot0.prePower, slot1.power, RougeMapEnum.PowerChangeDuration, slot0.frameCallback, slot0.doneCallback, slot0)

		AudioMgr.instance:trigger(AudioEnum.UI.DecreasePower)
	end

	slot0._txttotal.text = slot1.powerLimit
end

function slot0.frameCallback(slot0, slot1)
	slot1 = math.ceil(slot1)
	slot0._txttalent.text = slot1
	slot0.prePower = slot1
end

function slot0.doneCallback(slot0)
	slot0.tweenId = nil
end

function slot0.killTween(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end
end

function slot0.onUpdateTalentPoint(slot0)
	if not RougeMapHelper.checkMapViewOnTop() then
		slot0._waitUpdate = true

		return
	end

	slot0._waitUpdate = nil

	slot0:refreshTalentEffect()
	gohelper.setActive(slot0._goeffectget, true)
	TaskDispatcher.cancelTask(slot0._hideTalentGetEffect, slot0)
	TaskDispatcher.runDelay(slot0._hideTalentGetEffect, slot0, uv0)
end

function slot0.onCloseViewFinishCallBack(slot0)
	if slot0._waitUpdate then
		slot0:onUpdateTalentPoint()
	end
end

function slot0._hideTalentGetEffect(slot0)
	gohelper.setActive(slot0._goeffectget, false)
end

function slot0.onClose(slot0)
end

function slot0._btnclickOnClick(slot0)
	RougeController.instance:openRougeTalentView()
end

function slot0.destroy(slot0)
	slot0:killTween()
	slot0._btnclick:RemoveClickListener()
	TaskDispatcher.cancelTask(slot0._hideTalentGetEffect, slot0)
	slot0:__onDispose()
end

return slot0
