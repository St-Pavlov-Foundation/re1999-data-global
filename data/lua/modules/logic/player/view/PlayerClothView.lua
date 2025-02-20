module("modules.logic.player.view.PlayerClothView", package.seeall)

slot0 = class("PlayerClothView", BaseView)
slot1 = {
	"use",
	"move",
	"compose",
	"recover",
	"initial",
	"defeat",
	"death"
}

function slot0.onInitView(slot0)
	slot0._imgBg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._skillGO = gohelper.findChild(slot0.viewGO, "#scroll_skills")
	slot0._txtcn = gohelper.findChildText(slot0.viewGO, "right/info/skill/#txt_skillname")
	slot0._txten = gohelper.findChildText(slot0.viewGO, "right/info/skill/#txt_skillname/#txt_skillnameen")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "right/#scroll_info/Viewport/Content/#txt_skilldesc")
	slot0._furiousGO = gohelper.findChild(slot0.viewGO, "right/#scroll_info/Viewport/Content/furious")
	slot0._aspellGO = gohelper.findChild(slot0.viewGO, "right/#scroll_info/Viewport/Content/aspell")
	slot0._useBtnGO = gohelper.findChild(slot0.viewGO, "right/#btn_use")
	slot4 = "right/#go_inuse"
	slot0._inUsingGO = gohelper.findChild(slot0.viewGO, slot4)
	slot0._clickUseThis = gohelper.getClick(slot0._useBtnGO)
	slot0._txtFuriousPropList = slot0:getUserDataTb_()
	slot0._furiousPropGOList = slot0:getUserDataTb_()

	for slot4 = 1, #uv0 do
		table.insert(slot0._txtFuriousPropList, gohelper.findChildText(slot0.viewGO, string.format("right/#scroll_info/Viewport/Content/furious/furiouslist/#furiousitem%d/#txt_furious", slot4)))
		table.insert(slot0._furiousPropGOList, gohelper.findChild(slot0.viewGO, string.format("right/#scroll_info/Viewport/Content/furious/furiouslist/#furiousitem%d", slot4)))
	end

	slot4 = "right/#scroll_info/Viewport/Content/furious/#txt_furiousdesc"
	slot0._txtFuriousDesc = gohelper.findChildText(slot0.viewGO, slot4)
	slot0._txtAspellList = {}

	for slot4 = 1, 3 do
		table.insert(slot0._txtAspellList, gohelper.findChildText(slot0.viewGO, string.format("right/#scroll_info/Viewport/Content/aspell/aspells/#go_aspellitem%d/aspelldesc", slot4)))
	end

	slot0._modelList = {}

	for slot4, slot5 in ipairs(lua_cloth.configList) do
		slot0._modelList[slot5.id] = gohelper.findChild(slot0.viewGO, "model/" .. slot5.id)
	end
end

function slot0.addEvents(slot0)
	slot0._clickUseThis:AddClickListener(slot0._onClickUse, slot0)
end

function slot0.removeEvents(slot0)
	slot0._clickUseThis:RemoveClickListener()
end

function slot0.onOpen(slot0)
	slot0._curGroupModel = slot0.viewParam and slot0.viewParam.groupModel or HeroGroupModel.instance
	slot0._useCallback = slot0.viewParam and slot0.viewParam.useCallback or nil
	slot0._useCallbackObj = slot0.viewParam and slot0.viewParam.useCallbackObj or nil

	PlayerClothListViewModel.instance:setGroupModel(slot0._curGroupModel)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnModifyHeroGroup, slot0._onModifyHeroGroup, slot0)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnSnapshotSaveSucc, slot0._onSnapshotSaveSucc, slot0)
	PlayerController.instance:registerCallback(PlayerEvent.SelectCloth, slot0._onSelectCloth, slot0)
	slot0._imgBg:LoadImage(ResUrl.getPlayerClothIcon("full/zhujuejineng_guangyun_manual"))
	slot0:_initGroupInfo()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_formation_scale)
end

function slot0._initGroupInfo(slot0)
	slot1 = 0

	if slot0.viewParam and slot0.viewParam.isTip then
		slot1 = slot0.viewParam.id
	else
		slot3 = lua_cloth.configList[1].id

		if slot0._curGroupModel:getCurGroupMO() and slot2.clothId and slot2 and slot2.clothId > 0 then
			slot3 = slot2.clothId
		end

		slot1 = PlayerClothModel.instance:getSpEpisodeClothID() or slot3
	end

	PlayerController.instance:dispatchEvent(PlayerEvent.SelectCloth, slot1)
end

function slot0.onUpdateParam(slot0)
	slot0:_initGroupInfo()
end

function slot0.onCloseFinish(slot0)
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnModifyHeroGroup, slot0._onModifyHeroGroup, slot0)
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnSnapshotSaveSucc, slot0._onSnapshotSaveSucc, slot0)
	PlayerController.instance:unregisterCallback(PlayerEvent.SelectCloth, slot0._onSelectCloth, slot0)
	slot0._imgBg:UnLoadImage()
end

function slot0.onDestroyView(slot0)
	slot0._scrollRectWrap = nil
end

function slot0._onSelectCloth(slot0, slot1)
	slot0._clothId = slot1
	slot0._clothMO = PlayerClothModel.instance:getById(slot1)
	slot0._clothCO = lua_cloth.configDict[slot1]

	slot0:_refreshView()
end

function slot0._refreshView(slot0)
	slot0:_updateInfo()

	slot1 = slot0._clothMO and slot0._clothMO.level or 1
	slot2 = slot0.viewParam and slot0.viewParam.isTip

	if PlayerClothModel.instance:getSpEpisodeClothID() or slot2 then
		slot1 = 1
	end

	slot0._levelCO = lua_cloth_level.configDict[slot0._clothId] and slot3[slot1]

	gohelper.setActive(slot0._furiousGO, slot0._levelCO ~= nil)
	gohelper.setActive(slot0._aspellGO, slot0._levelCO ~= nil)
	gohelper.setActive(slot0._skillGO, not slot2)

	slot5 = slot0._curGroupModel:getCurGroupMO() and slot4.clothId == slot0._clothId

	gohelper.setActive(slot0._useBtnGO, slot0._levelCO ~= nil and not slot2 and not slot5)
	gohelper.setActive(slot0._inUsingGO, slot0._levelCO ~= nil and not slot2 and slot5)

	if slot0._levelCO then
		slot0:_updateLevelInfo()
	else
		logError("clothId = " .. slot0._clothId .. " level " .. slot1 .. "配置不存在")
	end
end

function slot0._updateInfo(slot0)
	slot1 = GameUtil.utf8sub(slot0._clothCO.name, 1, 1)
	slot2 = ""

	if GameUtil.utf8len(slot0._clothCO.name) >= 2 then
		slot2 = string.format("<size=55>%s</size>", GameUtil.utf8sub(slot0._clothCO.name, 2, GameUtil.utf8len(slot0._clothCO.name) - 1))
	end

	slot0._txtcn.text = slot1 .. slot2
	slot0._txten.text = slot0._clothCO.enname
	slot0._txtDesc.text = slot0._clothCO.desc

	for slot6, slot7 in ipairs(lua_cloth.configList) do
		gohelper.setActive(slot0._modelList[slot7.id], slot7.id == slot0._clothCO.id)
	end
end

function slot0._updateLevelInfo(slot0)
	for slot4, slot5 in ipairs(uv0) do
		slot7 = false

		if type(slot0._levelCO[slot5]) == "string" then
			slot7 = not string.nilorempty(slot6)
		elseif slot8 == "number" then
			slot7 = slot6 > 0
		end

		gohelper.setActive(slot0._furiousPropGOList[slot4], slot7)

		if slot7 then
			if slot5 == "recover" then
				slot6 = GameUtil.splitString2(slot0._levelCO.recover) and slot9[1] and slot9[1][2] or slot0._levelCO.recover
			end

			slot0._txtFuriousPropList[slot4].text = "+" .. slot6
		end
	end

	slot0._txtFuriousDesc.text = slot0._levelCO.desc

	for slot4 = 1, 3 do
		gohelper.setActive(slot0._txtAspellList[slot4].transform.parent.gameObject, lua_skill.configDict[slot0._levelCO["skill" .. slot4]] ~= nil)

		if slot6 then
			slot0._txtAspellList[slot4].text = FightConfig.instance:getSkillEffectDesc(nil, slot6)
		elseif slot5 > 0 then
			slot0._txtAspellList[slot4].text = ""

			logError("技能不存在：" .. slot5)
		end
	end
end

function slot0._onModifyHeroGroup(slot0)
	GameFacade.showToast(ToastEnum.PlayerCloth)
end

function slot0._onSnapshotSaveSucc(slot0)
	slot0:_refreshView()
	GameFacade.showToast(ToastEnum.PlayerCloth)
end

function slot0._onClickUse(slot0)
	slot0._curGroupModel:replaceCloth(slot0._clothId)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	slot0:_refreshView()
	slot0._curGroupModel:saveCurGroupData()

	if slot0._useCallback then
		slot0._useCallback(slot0._useCallbackObj)
	end
end

return slot0
