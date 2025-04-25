module("modules.logic.fight.view.FightCommonalitySlider", package.seeall)

slot0 = class("FightCommonalitySlider", FightBaseView)

function slot0.onInitView(slot0)
	slot0._slider = gohelper.findChildImage(slot0.viewGO, "slider/sliderbg/sliderfg")
	slot0._skillName = gohelper.findChildText(slot0.viewGO, "slider/txt_commonality")
	slot0._sliderText = gohelper.findChildText(slot0.viewGO, "slider/sliderbg/#txt_slidernum")
	slot0._tips = gohelper.findChild(slot0.viewGO, "tips")
	slot0._tipsTitle = gohelper.findChildText(slot0.viewGO, "tips/#txt_title")
	slot0._desText = gohelper.findChildText(slot0.viewGO, "tips/desccont/#txt_descitem")
	slot0._max = gohelper.findChild(slot0.viewGO, "slider/max")
	slot0._click = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "btn")
end

function slot0.onOpen(slot0)
	slot0:_refreshData()
	slot0:com_registMsg(FightMsgId.FightProgressValueChange, slot0._refreshData)
	slot0:com_registMsg(FightMsgId.FightMaxProgressValueChange, slot0._refreshData)
	slot0:com_registClick(slot0._click, slot0._onBtnClick)
	slot0:com_registFightEvent(FightEvent.TouchFightViewScreen, slot0._onTouchFightViewScreen)
end

function slot0._onTouchFightViewScreen(slot0)
	gohelper.setActive(slot0._tips, false)
end

function slot0._onBtnClick(slot0)
	gohelper.setActive(slot0._tips, true)
end

function slot0._refreshData(slot0)
	if lua_skill.configDict[FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ProgressSkill]] then
		slot0._skillName.text = slot2.name
		slot0._tipsTitle.text = slot2.name
		slot0._desText.text = FightConfig.instance:getSkillEffectDesc(nil, slot2)
	end

	if slot0._lastMax ~= (FightDataHelper.fieldMgr.progressMax <= FightDataHelper.fieldMgr.progress) then
		gohelper.setActive(slot0._max, slot5)
	end

	slot6 = slot3 / slot4
	slot0._sliderText.text = Mathf.Clamp(slot6 * 100, 0, 100) .. "%"

	ZProj.TweenHelper.KillByObj(slot0._slider)
	ZProj.TweenHelper.DOFillAmount(slot0._slider, slot6, 0.2 / FightModel.instance:getUISpeed())

	slot0._lastMax = slot5
end

function slot0.onClose(slot0)
	ZProj.TweenHelper.KillByObj(slot0._slider)
end

return slot0
