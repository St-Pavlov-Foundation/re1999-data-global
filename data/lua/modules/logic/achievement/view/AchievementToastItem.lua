module("modules.logic.achievement.view.AchievementToastItem", package.seeall)

local var_0_0 = class("AchievementToastItem", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0._toastItem = arg_1_1
	arg_1_0._toastParams = arg_1_2
	arg_1_0._achievementRootGO = arg_1_0._toastItem:getToastRootByType(ToastItem.ToastType.Achievement)

	arg_1_0:_onUpdate()
end

var_0_0.ToastGOName = "achievementToastItem"

function var_0_0._onUpdate(arg_2_0)
	arg_2_0.viewGO = gohelper.findChild(arg_2_0._achievementRootGO, var_0_0.ToastGOName)

	if not arg_2_0.viewGO then
		local var_2_0 = AchievementToastController.instance:tryGetToastAsset()

		if var_2_0 then
			arg_2_0.viewGO = gohelper.clone(var_2_0, arg_2_0._achievementRootGO, var_0_0.ToastGOName)
		else
			arg_2_0._toastLoader = arg_2_0._toastLoader or MultiAbLoader.New()

			arg_2_0._toastLoader:addPath(AchievementEnum.AchievementToastPath)
			arg_2_0._toastLoader:startLoad(arg_2_0._onToastLoadedCallBack, arg_2_0)
		end
	end

	if arg_2_0.viewGO then
		arg_2_0:initComponents()
		arg_2_0:refreshUI()
	end
end

function var_0_0._onToastLoadedCallBack(arg_3_0, arg_3_1)
	arg_3_0.viewGO = gohelper.findChild(arg_3_0._achievementRootGO, var_0_0.ToastGOName)

	if not arg_3_0.viewGO then
		local var_3_0 = arg_3_1:getAssetItem(AchievementEnum.AchievementToastPath):GetResource(AchievementEnum.AchievementToastPath)

		arg_3_0.viewGO = gohelper.clone(var_3_0, arg_3_0._achievementRootGO, var_0_0.ToastGOName)
	end

	arg_3_0:initComponents()
	arg_3_0:refreshUI()
end

function var_0_0.initComponents(arg_4_0)
	if arg_4_0.viewGO then
		arg_4_0._txtAchievement = gohelper.findChildText(arg_4_0.viewGO, "Tips/#txt_Achievement")
		arg_4_0._simageAssessIcon = gohelper.findChildSingleImage(arg_4_0.viewGO, "Tips/#simage_AssessIcon")
	end
end

function var_0_0.refreshUI(arg_5_0)
	arg_5_0._txtAchievement.text = tostring(arg_5_0._toastParams.toastTip)

	arg_5_0._simageAssessIcon:LoadImage(arg_5_0._toastParams.icon)
	arg_5_0._toastItem:setToastType(ToastItem.ToastType.Achievement)
end

function var_0_0.dispose(arg_6_0)
	if arg_6_0._toastLoader then
		arg_6_0._toastLoader:dispose()

		arg_6_0._toastLoader = nil
	end

	if arg_6_0._simageAssessIcon then
		arg_6_0._simageAssessIcon:UnLoadImage()
	end

	arg_6_0._toastItem = nil
	arg_6_0._toastParams = nil

	arg_6_0:__onDispose()
end

return var_0_0
