module("modules.logic.achievement.view.AchievementToastItem", package.seeall)

slot0 = class("AchievementToastItem", UserDataDispose)

function slot0.init(slot0, slot1, slot2)
	slot0:__onInit()

	slot0._toastItem = slot1
	slot0._toastParams = slot2
	slot0._achievementRootGO = slot0._toastItem:getToastRootByType(ToastItem.ToastType.Achievement)

	slot0:_onUpdate()
end

slot0.ToastGOName = "achievementToastItem"

function slot0._onUpdate(slot0)
	slot0.viewGO = gohelper.findChild(slot0._achievementRootGO, uv0.ToastGOName)

	if not slot0.viewGO then
		if AchievementToastController.instance:tryGetToastAsset() then
			slot0.viewGO = gohelper.clone(slot1, slot0._achievementRootGO, uv0.ToastGOName)
		else
			slot0._toastLoader = slot0._toastLoader or MultiAbLoader.New()

			slot0._toastLoader:addPath(AchievementEnum.AchievementToastPath)
			slot0._toastLoader:startLoad(slot0._onToastLoadedCallBack, slot0)
		end
	end

	if slot0.viewGO then
		slot0:initComponents()
		slot0:refreshUI()
	end
end

function slot0._onToastLoadedCallBack(slot0, slot1)
	slot0.viewGO = gohelper.findChild(slot0._achievementRootGO, uv0.ToastGOName)

	if not slot0.viewGO then
		slot0.viewGO = gohelper.clone(slot1:getAssetItem(AchievementEnum.AchievementToastPath):GetResource(AchievementEnum.AchievementToastPath), slot0._achievementRootGO, uv0.ToastGOName)
	end

	slot0:initComponents()
	slot0:refreshUI()
end

function slot0.initComponents(slot0)
	if slot0.viewGO then
		slot0._txtAchievement = gohelper.findChildText(slot0.viewGO, "Tips/#txt_Achievement")
		slot0._simageAssessIcon = gohelper.findChildSingleImage(slot0.viewGO, "Tips/#simage_AssessIcon")
	end
end

function slot0.refreshUI(slot0)
	slot0._txtAchievement.text = tostring(slot0._toastParams.toastTip)

	slot0._simageAssessIcon:LoadImage(slot0._toastParams.icon)
	slot0._toastItem:setToastType(ToastItem.ToastType.Achievement)
end

function slot0.dispose(slot0)
	if slot0._toastLoader then
		slot0._toastLoader:dispose()

		slot0._toastLoader = nil
	end

	if slot0._simageAssessIcon then
		slot0._simageAssessIcon:UnLoadImage()
	end

	slot0._toastItem = nil
	slot0._toastParams = nil

	slot0:__onDispose()
end

return slot0
