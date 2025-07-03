module("modules.logic.versionactivity2_7.act191.view.Act191InitBuildView", package.seeall)

local var_0_0 = class("Act191InitBuildView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollbuild = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_build")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.actId = Activity191Model.instance:getCurActId()
end

function var_0_0.onOpen(arg_5_0)
	Act191StatController.instance:onViewOpen(arg_5_0.viewName)
	arg_5_0:refreshUI()
end

function var_0_0.onClose(arg_6_0)
	local var_6_0 = arg_6_0.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(arg_6_0.viewName, var_6_0)
end

function var_0_0.onDestroyView(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.nextStep, arg_7_0)
	arg_7_0:clearIconList()
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0:initBuildSelectItem()

	arg_8_0._scrollbuild.horizontalNormalizedPosition = 0
end

function var_0_0.clearIconList(arg_9_0)
	if arg_9_0.collectionIconList then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.collectionIconList) do
			iter_9_1:UnLoadImage()
		end
	end
end

function var_0_0.initBuildSelectItem(arg_10_0)
	arg_10_0.buildCoList = lua_activity191_init_build.configDict[arg_10_0.actId]
	arg_10_0.collectionIconList = arg_10_0:getUserDataTb_()
	arg_10_0.bagAnimList = arg_10_0:getUserDataTb_()

	local var_10_0 = gohelper.findChild(arg_10_0.viewGO, "#scroll_build/Viewport/Content")
	local var_10_1 = gohelper.findChild(arg_10_0.viewGO, "#scroll_build/Viewport/Content/SelectItem")

	gohelper.CreateObjList(arg_10_0, arg_10_0._onInitBuildItem, arg_10_0.buildCoList, var_10_0, var_10_1)
end

function var_0_0._onInitBuildItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	gohelper.findChildText(arg_11_1, "name/txt_name").text = arg_11_2.name or ""

	local var_11_0 = gohelper.findChildButtonWithAudio(arg_11_1, "btn_select")

	arg_11_0:addClickCb(var_11_0, arg_11_0.selectInitBuild, arg_11_0, arg_11_3)

	local var_11_1 = gohelper.findChild(arg_11_1, "hero/heroitem")
	local var_11_2 = gohelper.findChild(arg_11_1, "collection/collectionitem")
	local var_11_3 = string.splitToNumber(arg_11_2.hero, "#")

	for iter_11_0, iter_11_1 in ipairs(var_11_3) do
		local var_11_4 = gohelper.cloneInPlace(var_11_1)
		local var_11_5 = arg_11_0:getResInst(arg_11_0.viewContainer._viewSetting.otherRes[1], var_11_4)
		local var_11_6 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_5, Act191HeroHeadItem)

		var_11_6:setData(nil, iter_11_1)
		var_11_6:setPreview()
	end

	local var_11_7 = string.splitToNumber(arg_11_2.item, "#")

	for iter_11_2, iter_11_3 in ipairs(var_11_7) do
		local var_11_8 = gohelper.cloneInPlace(var_11_2)
		local var_11_9 = Activity191Config.instance:getCollectionCo(iter_11_3)
		local var_11_10 = gohelper.findChildImage(var_11_8, "rare")
		local var_11_11 = gohelper.findChildSingleImage(var_11_8, "collectionicon")
		local var_11_12 = gohelper.findChildButtonWithAudio(var_11_8, "collectionicon")

		var_11_11:LoadImage(ResUrl.getRougeSingleBgCollection(var_11_9.icon))
		UISpriteSetMgr.instance:setAct174Sprite(var_11_10, "act174_propitembg_" .. var_11_9.rare)
		arg_11_0:addClickCb(var_11_12, arg_11_0.clickCollection, arg_11_0, iter_11_3)

		arg_11_0.collectionIconList[#arg_11_0.collectionIconList + 1] = var_11_11
	end

	gohelper.setActive(var_11_1, false)
	gohelper.setActive(var_11_2, false)

	arg_11_0.bagAnimList[arg_11_3] = arg_11_1:GetComponent(gohelper.Type_Animator)
	gohelper.findChildText(arg_11_1, "Coin/txt_Coin").text = arg_11_2.coin
end

function var_0_0.selectInitBuild(arg_12_0, arg_12_1)
	if arg_12_0.selectIndex then
		return
	end

	local var_12_0 = arg_12_0.buildCoList[arg_12_1]

	Activity191Rpc.instance:sendSelect191InitBuildRequest(arg_12_0.actId, var_12_0.style, arg_12_0.buildReply, arg_12_0)

	arg_12_0.selectIndex = arg_12_1
end

function var_0_0.buildReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 == 0 then
		local var_13_0 = arg_13_0.selectIndex

		if var_13_0 and arg_13_0.bagAnimList[var_13_0] then
			arg_13_0.bagAnimList[var_13_0]:Play(UIAnimationName.Close)
			AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shuori_qiyuan_reset)
		end

		TaskDispatcher.runDelay(arg_13_0.nextStep, arg_13_0, 0.67)

		local var_13_1 = Activity191Helper.getPlayerPrefs(arg_13_0.actId, "Act191GameCostTime", 0)

		Activity191Helper.setPlayerPrefs(arg_13_0.actId, "Act191GameCostTime", var_13_1 + 1)
	end
end

function var_0_0.clickCollection(arg_14_0, arg_14_1)
	local var_14_0 = {
		itemId = arg_14_1
	}

	Activity191Controller.instance:openCollectionTipView(var_14_0)
end

function var_0_0.nextStep(arg_15_0)
	arg_15_0.selectIndex = nil

	Activity191Controller.instance:nextStep()
	ViewMgr.instance:closeView(arg_15_0.viewName)
end

return var_0_0
