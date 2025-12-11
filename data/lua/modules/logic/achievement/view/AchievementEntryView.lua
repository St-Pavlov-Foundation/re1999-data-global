module("modules.logic.achievement.view.AchievementEntryView", package.seeall)

local var_0_0 = class("AchievementEntryView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_0.viewGO, "go_righttop/Total/#txt_total")
	arg_1_0._txtlevel1 = gohelper.findChildText(arg_1_0.viewGO, "go_righttop/Level1/#txt_level1")
	arg_1_0._txtlevel2 = gohelper.findChildText(arg_1_0.viewGO, "go_righttop/Level2/#txt_level2")
	arg_1_0._txtlevel3 = gohelper.findChildText(arg_1_0.viewGO, "go_righttop/Level3/#txt_level3")

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
	arg_4_0._simagebg:LoadImage(ResUrl.getAchievementIcon("achievement_mainfullbg"))

	arg_4_0._focusTypes = {
		AchievementEnum.Type.Story,
		AchievementEnum.Type.Normal,
		AchievementEnum.Type.GamePlay,
		AchievementEnum.Type.Activity,
		AchievementEnum.Type.NamePlate
	}
	arg_4_0._typeItems = {}
end

function var_0_0.onDestroyView(arg_5_0)
	AchievementEntryController.instance:onCloseView()

	for iter_5_0, iter_5_1 in pairs(arg_5_0._typeItems) do
		iter_5_1.btnself:RemoveClickListener()

		if iter_5_1.simageicon then
			iter_5_1.simageicon:UnLoadImage()
		end
	end

	arg_5_0._simagebg:UnLoadImage()
end

function var_0_0.onOpen(arg_6_0)
	AchievementController.instance:registerCallback(AchievementEvent.UpdateAchievements, arg_6_0.refreshCategoryItems, arg_6_0)
	AchievementController.instance:registerCallback(AchievementEvent.UpdateAchievementState, arg_6_0.updateAchievementState, arg_6_0)
	AchievementEntryController.instance:onOpenView()
	arg_6_0:refreshUI()
end

function var_0_0.updateAchievementState(arg_7_0)
	AchievementEntryController.instance:updateAchievementState()
	arg_7_0:refreshUI()
end

function var_0_0.onClose(arg_8_0)
	AchievementController.instance:unregisterCallback(AchievementEvent.UpdateAchievements, arg_8_0.refreshCategoryItems, arg_8_0)
	AchievementController.instance:unregisterCallback(AchievementEvent.UpdateAchievementState, arg_8_0.updateAchievementState, arg_8_0)
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0:refreshCategoryItems()
	arg_9_0:refreshLevelCollect()
end

var_0_0.LevelNum = 3

function var_0_0.refreshLevelCollect(arg_10_0)
	arg_10_0._txttotal.text = tostring(AchievementEntryModel.instance:getTotalFinishedCount())

	for iter_10_0 = 1, var_0_0.LevelNum do
		local var_10_0 = AchievementEntryModel.instance:getLevelCount(iter_10_0)

		arg_10_0["_txtlevel" .. tostring(iter_10_0)].text = string.format("%s", var_10_0)
	end
end

function var_0_0.refreshCategoryItems(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._focusTypes) do
		arg_11_0:refreshCategoryItem(iter_11_0, iter_11_1)
	end
end

function var_0_0.refreshCategoryItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getOrCreateCategory(arg_12_1, arg_12_2)
	local var_12_1, var_12_2 = AchievementEntryModel.instance:getFinishCount(arg_12_2)

	if arg_12_2 ~= AchievementEnum.Type.NamePlate then
		var_12_0.txtname.text = luaLang("achievemententryview_type_" .. arg_12_2)

		var_12_0.simageicon:LoadImage(ResUrl.getAchievementIcon("achievement_mainitem" .. arg_12_1))
	end

	var_12_0.txtprogress.text = string.format("<color=#c9c9c9><size=56>%s</size><size=40>/</size></color>%s", var_12_1, var_12_2)
end

function var_0_0.getOrCreateCategory(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0._typeItems[arg_13_1]

	if not var_13_0 then
		var_13_0 = arg_13_0:getUserDataTb_()
		var_13_0.achieveType = arg_13_2

		if var_13_0.achieveType ~= AchievementEnum.Type.NamePlate then
			var_13_0.go = gohelper.findChild(arg_13_0.viewGO, "go_books/#go_item" .. tostring(arg_13_1))
			var_13_0.txtprogress = gohelper.findChildText(var_13_0.go, "#txt_progress")
			var_13_0.txtname = gohelper.findChildText(var_13_0.go, "#txt_name")
			var_13_0.btnself = gohelper.findChildButtonWithAudio(var_13_0.go, "#btn_self")

			var_13_0.btnself:AddClickListener(arg_13_0.onClickCategory, arg_13_0, arg_13_1)

			local var_13_1 = gohelper.findChild(var_13_0.go, "go_reddot")

			var_13_0.reddot = RedDotController.instance:addRedDot(var_13_1, RedDotEnum.DotNode.AchievementFinish, arg_13_0._focusTypes[arg_13_1])
			var_13_0.simageicon = gohelper.findChildSingleImage(var_13_0.go, "#btn_self")
		else
			var_13_0.go = gohelper.findChild(arg_13_0.viewGO, "#go_misihai_entrance")
			var_13_0.txtprogress = gohelper.findChildText(var_13_0.go, "#txt_progress")
			var_13_0.txtname = gohelper.findChildText(var_13_0.go, "#txt_name")
			var_13_0.btnself = gohelper.findChildButtonWithAudio(var_13_0.go, "image_misihai_entrance")

			var_13_0.btnself:AddClickListener(arg_13_0.onClickCategory, arg_13_0, arg_13_1)
		end

		arg_13_0._typeItems[arg_13_1] = var_13_0
	end

	return var_13_0
end

function var_0_0.onClickCategory(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._focusTypes[arg_14_1]

	AchievementController.instance:openAchievementMainView(var_14_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Rolesopen)
end

return var_0_0
