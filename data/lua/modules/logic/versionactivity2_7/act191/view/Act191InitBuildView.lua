module("modules.logic.versionactivity2_7.act191.view.Act191InitBuildView", package.seeall)

local var_0_0 = class("Act191InitBuildView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollbuild = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_build")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0.actId = Activity191Model.instance:getCurActId()
end

function var_0_0.onOpen(arg_3_0)
	Act191StatController.instance:onViewOpen(arg_3_0.viewName)

	arg_3_0.initBuildInfo = Activity191Model.instance:getActInfo():getGameInfo().initBuildInfo

	arg_3_0:refreshUI()
end

function var_0_0.onClose(arg_4_0)
	local var_4_0 = arg_4_0.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(arg_4_0.viewName, var_4_0)
end

function var_0_0.onDestroyView(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.nextStep, arg_5_0)
end

function var_0_0.refreshUI(arg_6_0)
	arg_6_0.buildCoList = lua_activity191_init_build.configDict[arg_6_0.actId]
	arg_6_0.bagAnimList = arg_6_0:getUserDataTb_()

	local var_6_0 = gohelper.findChild(arg_6_0.viewGO, "#scroll_build/Viewport/Content")
	local var_6_1 = gohelper.findChild(arg_6_0.viewGO, "#scroll_build/Viewport/Content/SelectItem")

	gohelper.CreateObjList(arg_6_0, arg_6_0._onInitBuildItem, arg_6_0.initBuildInfo, var_6_0, var_6_1)
	gohelper.setActive(var_6_1, false)

	arg_6_0._scrollbuild.horizontalNormalizedPosition = 0

	if arg_6_0.extraBuildIndex and not GuideModel.instance:isGuideFinish(31504) then
		local var_6_2 = "UIRoot/POPUP_TOP/Act191InitBuildView/#scroll_build/Viewport/Content/" .. arg_6_0.extraBuildIndex

		GuideModel.instance:setNextStepGOPath(31504, 1, var_6_2)
		Activity191Controller.instance:dispatchEvent(Activity191Event.ZTrigger31504)
	end
end

function var_0_0._onInitBuildItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = lua_activity191_init_build.configDict[arg_7_0.actId][arg_7_2.id]

	gohelper.findChildText(arg_7_1, "name/txt_name").text = var_7_0.name or ""
	gohelper.findChildText(arg_7_1, "Coin/txt_Coin").text = arg_7_2.coin

	if not arg_7_0.extraBuildIndex and arg_7_2.coin ~= var_7_0.coin then
		arg_7_0.extraBuildIndex = arg_7_3
	end

	local var_7_1 = gohelper.findChild(arg_7_1, "Coin/effect")

	gohelper.setActive(var_7_1, arg_7_2.coin ~= var_7_0.coin)

	local var_7_2 = gohelper.findChildButtonWithAudio(arg_7_1, "btn_select")

	arg_7_0:addClickCb(var_7_2, arg_7_0.selectInitBuild, arg_7_0, arg_7_3)

	local var_7_3 = gohelper.findChild(arg_7_1, "hero/heroitem")
	local var_7_4 = gohelper.findChild(arg_7_1, "collection/collectionitem")

	for iter_7_0, iter_7_1 in ipairs(arg_7_2.detail) do
		if not arg_7_0.extraBuildIndex and iter_7_1.type == Activity191Enum.InitBuildType.Extra then
			arg_7_0.extraBuildIndex = arg_7_3
		end

		local var_7_5 = iter_7_1.type == Activity191Enum.InitBuildType.Extra

		for iter_7_2, iter_7_3 in ipairs(iter_7_1.addHero) do
			arg_7_0:addHero(var_7_3, iter_7_3, var_7_5)
		end

		for iter_7_4, iter_7_5 in ipairs(iter_7_1.addItem) do
			arg_7_0:addCollection(var_7_4, iter_7_5, var_7_5)
		end
	end

	gohelper.setActive(var_7_3, false)
	gohelper.setActive(var_7_4, false)

	arg_7_0.bagAnimList[arg_7_3] = arg_7_1:GetComponent(gohelper.Type_Animator)
end

function var_0_0.addHero(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = gohelper.cloneInPlace(arg_8_1)
	local var_8_1 = arg_8_0:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, var_8_0)
	local var_8_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_1, Act191HeroHeadItem)

	var_8_2:setData(nil, arg_8_2)
	var_8_2:setPreview()
	var_8_2:setExtraEffect(arg_8_3)
end

function var_0_0.addCollection(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = gohelper.cloneInPlace(arg_9_1)
	local var_9_1 = Activity191Config.instance:getCollectionCo(arg_9_2)
	local var_9_2 = gohelper.findChildImage(var_9_0, "rare")

	UISpriteSetMgr.instance:setAct174Sprite(var_9_2, "act174_propitembg_" .. var_9_1.rare)
	gohelper.findChildSingleImage(var_9_0, "collectionicon"):LoadImage(ResUrl.getRougeSingleBgCollection(var_9_1.icon))

	local var_9_3 = gohelper.findChildButtonWithAudio(var_9_0, "collectionicon")

	arg_9_0:addClickCb(var_9_3, arg_9_0.clickCollection, arg_9_0, arg_9_2)

	local var_9_4 = gohelper.findChild(var_9_0, "effect")

	gohelper.setActive(var_9_4, arg_9_3)
end

function var_0_0.selectInitBuild(arg_10_0, arg_10_1)
	if arg_10_0.selectIndex then
		return
	end

	local var_10_0 = arg_10_0.initBuildInfo[arg_10_1]

	Activity191Rpc.instance:sendSelect191InitBuildRequest(arg_10_0.actId, var_10_0.id, arg_10_0.buildReply, arg_10_0)

	arg_10_0.selectIndex = arg_10_1
end

function var_0_0.buildReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 == 0 then
		local var_11_0 = arg_11_0.selectIndex

		if var_11_0 and arg_11_0.bagAnimList[var_11_0] then
			arg_11_0.bagAnimList[var_11_0]:Play(UIAnimationName.Close)
			AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shuori_qiyuan_reset)
		end

		TaskDispatcher.runDelay(arg_11_0.nextStep, arg_11_0, 0.67)

		local var_11_1 = Activity191Helper.getPlayerPrefs(arg_11_0.actId, "Act191GameCostTime", 0)

		Activity191Helper.setPlayerPrefs(arg_11_0.actId, "Act191GameCostTime", var_11_1 + 1)
	end
end

function var_0_0.clickCollection(arg_12_0, arg_12_1)
	local var_12_0 = {
		itemId = arg_12_1
	}

	Activity191Controller.instance:openCollectionTipView(var_12_0)
end

function var_0_0.nextStep(arg_13_0)
	arg_13_0.selectIndex = nil

	Activity191Controller.instance:nextStep()
	ViewMgr.instance:closeView(arg_13_0.viewName)
end

return var_0_0
