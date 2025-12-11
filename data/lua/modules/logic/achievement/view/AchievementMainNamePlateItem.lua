module("modules.logic.achievement.view.AchievementMainNamePlateItem", package.seeall)

local var_0_0 = class("AchievementMainNamePlateItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goIcon = gohelper.findChild(arg_1_0.viewGO, "go_icon")
	arg_1_0._btnclick = gohelper.findChildButton(arg_1_0.viewGO, "#btn_click")

	arg_1_0:_initLevelItems()

	arg_1_0._prefab = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._onClickBtn, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._onClickBtn(arg_4_0)
	if arg_4_0._mo and arg_4_0._mo.id then
		local var_4_0 = {
			achievementId = arg_4_0._mo.id,
			achievementIds = AchievementMainListModel.instance:getCurrentAchievementIds()
		}

		ViewMgr.instance:openView(ViewName.AchievementNamePlateLevelView, var_4_0)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_saga)
	end
end

function var_0_0._initLevelItems(arg_5_0)
	arg_5_0.levelItemList = {}

	for iter_5_0 = 1, 3 do
		local var_5_0 = {
			go = gohelper.findChild(arg_5_0._goIcon, "level" .. iter_5_0)
		}

		var_5_0.unlock = gohelper.findChild(var_5_0.go, "#go_UnLocked")
		var_5_0.lock = gohelper.findChild(var_5_0.go, "#go_Locked")
		var_5_0.gounlockbg = gohelper.findChild(var_5_0.unlock, "#simage_bg")
		var_5_0.simageunlocktitle = gohelper.findChildSingleImage(var_5_0.unlock, "#simage_title")
		var_5_0.txtunlocklevel = gohelper.findChildText(var_5_0.unlock, "#txt_level")
		var_5_0.simagelockbg = gohelper.findChildSingleImage(var_5_0.lock, "#simage_bg")
		var_5_0.simagelocktitle = gohelper.findChildSingleImage(var_5_0.lock, "#simage_title")
		var_5_0.txtlocklevel = gohelper.findChildText(var_5_0.lock, "#txt_level")

		gohelper.setActive(var_5_0.go, false)
		table.insert(arg_5_0.levelItemList, var_5_0)
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._animator = gohelper.onceAddComponent(arg_6_0.viewGO, typeof(UnityEngine.Animator))

	arg_6_0:addEventCb(AchievementMainController.instance, AchievementEvent.OnFocusAchievementFinished, arg_6_0._onFocusFinished, arg_6_0)
end

function var_0_0.onDestroy(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	if AchievementMainCommonModel.instance:getCurrentViewType() ~= AchievementEnum.ViewType.Tile then
		return
	end

	arg_8_0._mo = arg_8_1

	arg_8_0:refreshUI()
end

function var_0_0.refreshUI(arg_9_0)
	if not AchievementMainCommonModel.instance:checkIsNamePlate() then
		return
	end

	local var_9_0 = false
	local var_9_1 = AchievementConfig.instance:getAchievement(arg_9_0._mo.id)

	if var_9_1 then
		local var_9_2 = AchievementMainCommonModel.instance:getCurrentSortType()
		local var_9_3 = AchievementMainCommonModel.instance:getCurrentFilterType()
		local var_9_4 = arg_9_0._mo:getFilterTaskList(var_9_2, var_9_3)
		local var_9_5

		if var_9_4 then
			for iter_9_0, iter_9_1 in ipairs(var_9_4) do
				local var_9_6 = arg_9_0.levelItemList[iter_9_0]
				local var_9_7 = AchievementModel.instance:getById(iter_9_1.id)
				local var_9_8 = var_9_7 and var_9_7.hasFinished

				if var_9_8 then
					var_9_5 = iter_9_1.level
				end

				gohelper.setActive(var_9_6.unlock, var_9_8)
				gohelper.setActive(var_9_6.lock, not var_9_8)

				local var_9_9
				local var_9_10
				local var_9_11

				if iter_9_1.image and not string.nilorempty(iter_9_1.image) then
					local var_9_12 = string.split(iter_9_1.image, "#")

					var_9_9 = var_9_12[1]
					var_9_10 = var_9_12[2]
					var_9_11 = var_9_12[3]
				end

				if var_9_8 then
					local function var_9_13()
						local var_10_0 = var_9_6._bgLoader:getInstGO()

						arg_9_0._prefab[iter_9_0] = var_10_0
					end

					if not arg_9_0._prefab[iter_9_0] then
						var_9_6._bgLoader = PrefabInstantiate.Create(var_9_6.gounlockbg)

						var_9_6._bgLoader:startLoad(AchievementUtils.getBgPrefabUrl(var_9_9), var_9_13, arg_9_0)
					end

					var_9_6.simageunlocktitle:LoadImage(ResUrl.getAchievementLangIcon(var_9_10))
				else
					var_9_6.simagelockbg:LoadImage(ResUrl.getAchievementIcon(var_9_11))
					var_9_6.simagelocktitle:LoadImage(ResUrl.getAchievementLangIcon(var_9_10))
				end

				local var_9_14 = iter_9_1.listenerType
				local var_9_15 = AchievementUtils.getAchievementProgressBySourceType(var_9_1.rule)
				local var_9_16

				if var_9_14 and var_9_14 == "TowerPassLayer" then
					if iter_9_1.listenerParam and not string.nilorempty(iter_9_1.listenerParam) then
						local var_9_17 = string.split(iter_9_1.listenerParam, "#")

						var_9_16 = var_9_17 and var_9_17[3]
						var_9_16 = var_9_16 * 10
					end
				else
					var_9_16 = iter_9_1 and iter_9_1.maxProgress
				end

				if var_9_8 then
					var_9_6.txtunlocklevel.text = var_9_16 < var_9_15 and var_9_15 or var_9_16
					var_9_6.txtlocklevel.text = var_9_16 < var_9_15 and var_9_15 or var_9_16
				else
					var_9_6.txtunlocklevel.text = var_9_16 < var_9_15 and var_9_16 or var_9_15
					var_9_6.txtlocklevel.text = var_9_16 < var_9_15 and var_9_16 or var_9_15
				end
			end

			if var_9_5 and var_9_5 > 0 then
				for iter_9_2, iter_9_3 in ipairs(arg_9_0.levelItemList) do
					if iter_9_2 == var_9_5 then
						gohelper.setActive(iter_9_3.go, true)
					else
						gohelper.setActive(iter_9_3.go, false)
					end
				end
			else
				gohelper.setActive(arg_9_0.levelItemList[1].go, true)
			end
		end
	end
end

function var_0_0.setIconColor(arg_11_0, arg_11_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_11_0._imageicon, arg_11_1 or "#FFFFFF")
end

function var_0_0.playAchievementAnim(arg_12_0)
	return
end

function var_0_0._onFocusFinished(arg_13_0)
	return
end

return var_0_0
