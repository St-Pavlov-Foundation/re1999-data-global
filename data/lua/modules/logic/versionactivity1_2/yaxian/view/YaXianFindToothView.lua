module("modules.logic.versionactivity1_2.yaxian.view.YaXianFindToothView", package.seeall)

slot0 = class("YaXianFindToothView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "main/#txt_name")
	slot0._txtunlockskill = gohelper.findChildText(slot0.viewGO, "main/unlockbg/#txt_unlockskill")
	slot0._txtup = gohelper.findChildText(slot0.viewGO, "main/#txt_up/")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onFullClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getYaXianImage("img_huode_bg_2"))

	slot0.fullClick = gohelper.getClick(slot0._simagebg.gameObject)

	slot0.fullClick:AddClickListener(slot0.onFullClick, slot0)

	slot0.toothIcon = gohelper.findChildSingleImage(slot0.viewGO, "main/iconbg/icon")
	slot0.goUnlockSkill = gohelper.findChild(slot0.viewGO, "main/unlockbg")
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onOpen(slot0)
	slot0.toothId = slot0.viewParam.toothId
	slot0.toothConfig = YaXianConfig.instance:getToothConfig(slot0.toothId)

	slot0.toothIcon:LoadImage(ResUrl.getYaXianImage(slot0.toothConfig.icon))

	slot0._txtname.text = slot0.toothConfig.name
	slot1 = YaXianConfig.instance:getToothUnlockSkill(slot0.toothId)

	gohelper.setActive(slot0.goUnlockSkill, slot1)

	if slot1 then
		slot0._txtunlockskill.text = luaLang("versionactivity_1_2_yaxian_unlock_skill_" .. slot1)
	end

	slot0._txtup.text = string.format(luaLang("versionactivity_1_2_yaxian_up_to_level"), HeroConfig.instance:getCommonLevelDisplay(lua_hero_trial.configDict[YaXianEnum.HeroTrialId][YaXianConfig.instance:getToothUnlockHeroTemplate(slot0.toothId)] and slot3.level or 0))
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0.toothIcon:UnLoadImage()
	slot0.fullClick:RemoveClickListener()
end

return slot0
