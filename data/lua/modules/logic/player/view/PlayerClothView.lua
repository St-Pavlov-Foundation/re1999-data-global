module("modules.logic.player.view.PlayerClothView", package.seeall)

local var_0_0 = class("PlayerClothView", BaseView)
local var_0_1 = {
	"use",
	"move",
	"compose",
	"recover",
	"initial",
	"defeat",
	"death"
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imgBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._skillGO = gohelper.findChild(arg_1_0.viewGO, "#scroll_skills")
	arg_1_0._txtcn = gohelper.findChildText(arg_1_0.viewGO, "right/info/skill/#txt_skillname")
	arg_1_0._txten = gohelper.findChildText(arg_1_0.viewGO, "right/info/skill/#txt_skillname/#txt_skillnameen")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "right/#scroll_info/Viewport/Content/#txt_skilldesc")
	arg_1_0._furiousGO = gohelper.findChild(arg_1_0.viewGO, "right/#scroll_info/Viewport/Content/furious")
	arg_1_0._aspellGO = gohelper.findChild(arg_1_0.viewGO, "right/#scroll_info/Viewport/Content/aspell")
	arg_1_0._useBtnGO = gohelper.findChild(arg_1_0.viewGO, "right/#btn_use")
	arg_1_0._inUsingGO = gohelper.findChild(arg_1_0.viewGO, "right/#go_inuse")
	arg_1_0._clickUseThis = gohelper.getClick(arg_1_0._useBtnGO)
	arg_1_0._txtFuriousPropList = arg_1_0:getUserDataTb_()
	arg_1_0._furiousPropGOList = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, #var_0_1 do
		local var_1_0 = string.format("right/#scroll_info/Viewport/Content/furious/furiouslist/#furiousitem%d/#txt_furious", iter_1_0)

		table.insert(arg_1_0._txtFuriousPropList, gohelper.findChildText(arg_1_0.viewGO, var_1_0))

		local var_1_1 = string.format("right/#scroll_info/Viewport/Content/furious/furiouslist/#furiousitem%d", iter_1_0)

		table.insert(arg_1_0._furiousPropGOList, gohelper.findChild(arg_1_0.viewGO, var_1_1))
	end

	arg_1_0._txtFuriousDesc = gohelper.findChildText(arg_1_0.viewGO, "right/#scroll_info/Viewport/Content/furious/#txt_furiousdesc")
	arg_1_0._txtAspellList = {}

	for iter_1_1 = 1, 3 do
		local var_1_2 = string.format("right/#scroll_info/Viewport/Content/aspell/aspells/#go_aspellitem%d/aspelldesc", iter_1_1)

		table.insert(arg_1_0._txtAspellList, gohelper.findChildText(arg_1_0.viewGO, var_1_2))
	end

	arg_1_0._modelList = {}

	for iter_1_2, iter_1_3 in ipairs(lua_cloth.configList) do
		local var_1_3 = gohelper.findChild(arg_1_0.viewGO, "model/" .. iter_1_3.id)

		arg_1_0._modelList[iter_1_3.id] = var_1_3
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._clickUseThis:AddClickListener(arg_2_0._onClickUse, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._clickUseThis:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._curGroupModel = arg_4_0.viewParam and arg_4_0.viewParam.groupModel or HeroGroupModel.instance
	arg_4_0._useCallback = arg_4_0.viewParam and arg_4_0.viewParam.useCallback or nil
	arg_4_0._useCallbackObj = arg_4_0.viewParam and arg_4_0.viewParam.useCallbackObj or nil

	PlayerClothListViewModel.instance:setGroupModel(arg_4_0._curGroupModel)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnModifyHeroGroup, arg_4_0._onModifyHeroGroup, arg_4_0)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnSnapshotSaveSucc, arg_4_0._onSnapshotSaveSucc, arg_4_0)
	PlayerController.instance:registerCallback(PlayerEvent.SelectCloth, arg_4_0._onSelectCloth, arg_4_0)
	arg_4_0._imgBg:LoadImage(ResUrl.getPlayerClothIcon("full/zhujuejineng_guangyun_manual"))
	arg_4_0:_initGroupInfo()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_formation_scale)
end

function var_0_0._initGroupInfo(arg_5_0)
	local var_5_0 = 0

	if arg_5_0.viewParam and arg_5_0.viewParam.isTip then
		var_5_0 = arg_5_0.viewParam.id
	else
		local var_5_1 = arg_5_0._curGroupModel:getCurGroupMO()
		local var_5_2 = lua_cloth.configList[1].id

		if var_5_1 and var_5_1.clothId and var_5_1 and var_5_1.clothId > 0 then
			var_5_2 = var_5_1.clothId
		end

		var_5_0 = PlayerClothModel.instance:getSpEpisodeClothID() or var_5_2
	end

	PlayerController.instance:dispatchEvent(PlayerEvent.SelectCloth, var_5_0)
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:_initGroupInfo()
end

function var_0_0.onCloseFinish(arg_7_0)
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnModifyHeroGroup, arg_7_0._onModifyHeroGroup, arg_7_0)
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnSnapshotSaveSucc, arg_7_0._onSnapshotSaveSucc, arg_7_0)
	PlayerController.instance:unregisterCallback(PlayerEvent.SelectCloth, arg_7_0._onSelectCloth, arg_7_0)
	arg_7_0._imgBg:UnLoadImage()
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0._scrollRectWrap = nil
end

function var_0_0._onSelectCloth(arg_9_0, arg_9_1)
	arg_9_0._clothId = arg_9_1
	arg_9_0._clothMO = PlayerClothModel.instance:getById(arg_9_1)
	arg_9_0._clothCO = lua_cloth.configDict[arg_9_1]

	arg_9_0:_refreshView()
end

function var_0_0._refreshView(arg_10_0)
	arg_10_0:_updateInfo()

	local var_10_0 = arg_10_0._clothMO and arg_10_0._clothMO.level or 1
	local var_10_1 = arg_10_0.viewParam and arg_10_0.viewParam.isTip

	if PlayerClothModel.instance:getSpEpisodeClothID() or var_10_1 then
		var_10_0 = 1
	end

	local var_10_2 = lua_cloth_level.configDict[arg_10_0._clothId]

	arg_10_0._levelCO = var_10_2 and var_10_2[var_10_0]

	gohelper.setActive(arg_10_0._furiousGO, arg_10_0._levelCO ~= nil)
	gohelper.setActive(arg_10_0._aspellGO, arg_10_0._levelCO ~= nil)
	gohelper.setActive(arg_10_0._skillGO, not var_10_1)

	local var_10_3 = arg_10_0._curGroupModel:getCurGroupMO()
	local var_10_4 = var_10_3 and var_10_3.clothId == arg_10_0._clothId

	gohelper.setActive(arg_10_0._useBtnGO, arg_10_0._levelCO ~= nil and not var_10_1 and not var_10_4)
	gohelper.setActive(arg_10_0._inUsingGO, arg_10_0._levelCO ~= nil and not var_10_1 and var_10_4)

	if arg_10_0._levelCO then
		arg_10_0:_updateLevelInfo()
	else
		logError("clothId = " .. arg_10_0._clothId .. " level " .. var_10_0 .. "配置不存在")
	end
end

function var_0_0._updateInfo(arg_11_0)
	local var_11_0 = GameUtil.utf8sub(arg_11_0._clothCO.name, 1, 1)
	local var_11_1 = ""

	if GameUtil.utf8len(arg_11_0._clothCO.name) >= 2 then
		var_11_1 = string.format("<size=55>%s</size>", GameUtil.utf8sub(arg_11_0._clothCO.name, 2, GameUtil.utf8len(arg_11_0._clothCO.name) - 1))
	end

	arg_11_0._txtcn.text = var_11_0 .. var_11_1
	arg_11_0._txten.text = arg_11_0._clothCO.enname
	arg_11_0._txtDesc.text = arg_11_0._clothCO.desc

	for iter_11_0, iter_11_1 in ipairs(lua_cloth.configList) do
		local var_11_2 = arg_11_0._modelList[iter_11_1.id]

		gohelper.setActive(var_11_2, iter_11_1.id == arg_11_0._clothCO.id)
	end
end

function var_0_0._updateLevelInfo(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(var_0_1) do
		local var_12_0 = arg_12_0._levelCO[iter_12_1]
		local var_12_1 = false
		local var_12_2 = type(var_12_0)

		if var_12_2 == "string" then
			var_12_1 = not string.nilorempty(var_12_0)
		elseif var_12_2 == "number" then
			var_12_1 = var_12_0 > 0
		end

		gohelper.setActive(arg_12_0._furiousPropGOList[iter_12_0], var_12_1)

		if var_12_1 then
			if iter_12_1 == "recover" then
				local var_12_3 = GameUtil.splitString2(arg_12_0._levelCO.recover)

				var_12_0 = var_12_3 and var_12_3[1] and var_12_3[1][2] or arg_12_0._levelCO.recover
			end

			arg_12_0._txtFuriousPropList[iter_12_0].text = "+" .. var_12_0
		end
	end

	arg_12_0._txtFuriousDesc.text = arg_12_0._levelCO.desc

	for iter_12_2 = 1, 3 do
		local var_12_4 = arg_12_0._levelCO["skill" .. iter_12_2]
		local var_12_5 = lua_skill.configDict[var_12_4]

		gohelper.setActive(arg_12_0._txtAspellList[iter_12_2].transform.parent.gameObject, var_12_5 ~= nil)

		if var_12_5 then
			arg_12_0._txtAspellList[iter_12_2].text = FightConfig.instance:getSkillEffectDesc(nil, var_12_5)
		elseif var_12_4 > 0 then
			arg_12_0._txtAspellList[iter_12_2].text = ""

			logError("技能不存在：" .. var_12_4)
		end
	end
end

function var_0_0._onModifyHeroGroup(arg_13_0)
	GameFacade.showToast(ToastEnum.PlayerCloth)
end

function var_0_0._onSnapshotSaveSucc(arg_14_0)
	arg_14_0:_refreshView()
	GameFacade.showToast(ToastEnum.PlayerCloth)
end

function var_0_0._onClickUse(arg_15_0)
	arg_15_0._curGroupModel:replaceCloth(arg_15_0._clothId)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	arg_15_0:_refreshView()
	arg_15_0._curGroupModel:saveCurGroupData()

	if arg_15_0._useCallback then
		arg_15_0._useCallback(arg_15_0._useCallbackObj)
	end
end

return var_0_0
