module("modules.logic.achievement.view.AchievementNamePlatePanelView", package.seeall)

local var_0_0 = class("AchievementNamePlatePanelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goIcon = gohelper.findChild(arg_1_0.viewGO, "go_icon")
	arg_1_0._btnView = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_view")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._btnImage = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_icon/#btn_image")

	arg_1_0:_initLevelItems()

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnView:AddClickListener(arg_2_0._btnViewOnClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0._btnImage:AddClickListener(arg_2_0._btnImageOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnView:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnImage:RemoveClickListener()
end

function var_0_0._initLevelItems(arg_4_0)
	arg_4_0.levelItemList = {}

	for iter_4_0 = 1, 3 do
		local var_4_0 = {
			go = gohelper.findChild(arg_4_0._goIcon, "level" .. iter_4_0)
		}

		var_4_0.unlock = gohelper.findChild(var_4_0.go, "#go_UnLocked")
		var_4_0.lock = gohelper.findChild(var_4_0.go, "#go_Locked")
		var_4_0.gounlockbg = gohelper.findChild(var_4_0.unlock, "#simage_bg")
		var_4_0.simageunlocktitle = gohelper.findChildSingleImage(var_4_0.unlock, "#simage_title")
		var_4_0.txtunlocklevel = gohelper.findChildText(var_4_0.unlock, "#txt_level")
		var_4_0.simagelockbg = gohelper.findChildSingleImage(var_4_0.lock, "#simage_bg")
		var_4_0.simagelocktitle = gohelper.findChildSingleImage(var_4_0.lock, "#simage_title")
		var_4_0.txtlocklevel = gohelper.findChildText(var_4_0.lock, "#txt_level")

		gohelper.setActive(var_4_0.go, false)
		table.insert(arg_4_0.levelItemList, var_4_0)
	end
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._co = arg_5_0.viewParam.taskCo
	arg_5_0._id = arg_5_0._co.achievementId

	arg_5_0:refreshUI()
end

function var_0_0.refreshUI(arg_6_0)
	local var_6_0 = arg_6_0._co.level
	local var_6_1 = AchievementConfig.instance:getAchievement(arg_6_0._id)
	local var_6_2 = arg_6_0.levelItemList[var_6_0]
	local var_6_3 = AchievementModel.instance:getById(arg_6_0._co.id)
	local var_6_4 = var_6_3 and var_6_3.hasFinished

	gohelper.setActive(var_6_2.unlock, var_6_4)
	gohelper.setActive(var_6_2.lock, not var_6_4)

	local var_6_5
	local var_6_6
	local var_6_7

	if arg_6_0._co.image and not string.nilorempty(arg_6_0._co.image) then
		local var_6_8 = string.split(arg_6_0._co.image, "#")

		var_6_5 = var_6_8[1]
		var_6_6 = var_6_8[2]
		var_6_7 = var_6_8[3]
	end

	if var_6_4 then
		local function var_6_9()
			local var_7_0 = var_6_2._bgLoader:getInstGO()
		end

		var_6_2._bgLoader = PrefabInstantiate.Create(var_6_2.gounlockbg)

		var_6_2._bgLoader:startLoad(AchievementUtils.getBgPrefabUrl(var_6_5), var_6_9, arg_6_0)
		var_6_2.simageunlocktitle:LoadImage(ResUrl.getAchievementLangIcon(var_6_6))
	else
		var_6_2.simagelockbg:LoadImage(ResUrl.getAchievementIcon(var_6_7))
		var_6_2.simagelocktitle:LoadImage(ResUrl.getAchievementLangIcon(var_6_6))
	end

	local var_6_10 = arg_6_0._co.listenerType
	local var_6_11 = AchievementUtils.getAchievementProgressBySourceType(var_6_1.rule)
	local var_6_12

	if var_6_10 and var_6_10 == "TowerPassLayer" then
		if arg_6_0._co.listenerParam and not string.nilorempty(arg_6_0._co.listenerParam) then
			local var_6_13 = string.split(arg_6_0._co.listenerParam, "#")

			var_6_12 = var_6_13 and var_6_13[3]
			var_6_12 = var_6_12 * 10
		end
	else
		var_6_12 = arg_6_0._co and arg_6_0._co.maxProgress
	end

	if var_6_4 then
		var_6_2.txtunlocklevel.text = var_6_12 < var_6_11 and var_6_11 or var_6_12
		var_6_2.txtlocklevel.text = var_6_12 < var_6_11 and var_6_11 or var_6_12
	else
		var_6_2.txtunlocklevel.text = var_6_12 < var_6_11 and var_6_12 or var_6_11
		var_6_2.txtlocklevel.text = var_6_12 < var_6_11 and var_6_12 or var_6_11
	end

	gohelper.setActive(var_6_2.go, true)
end

function var_0_0._btnCloseOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._btnViewOnClick(arg_9_0)
	AchievementController.instance:openAchievementMainViewAndFocus(AchievementEnum.AchievementType.Single, arg_9_0._id, false)
end

function var_0_0._btnImageOnClick(arg_10_0)
	local var_10_0 = AchievementConfig.instance:getTasksByAchievementId(arg_10_0._id)
	local var_10_1 = {}

	if var_10_0 then
		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			if iter_10_1 then
				table.insert(var_10_1, iter_10_1.id)
			end
		end
	end

	local var_10_2 = {
		achievementId = arg_10_0._id,
		achievementIds = var_10_1
	}

	ViewMgr.instance:openView(ViewName.AchievementNamePlateLevelView, var_10_2)
end

return var_0_0
