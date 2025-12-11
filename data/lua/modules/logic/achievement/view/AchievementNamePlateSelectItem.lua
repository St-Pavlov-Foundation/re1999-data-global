module("modules.logic.achievement.view.AchievementNamePlateSelectItem", package.seeall)

local var_0_0 = class("AchievementNamePlateSelectItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goIcon = gohelper.findChild(arg_1_0.viewGO, "go_icon")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_groupselected")
	arg_1_0._btnclick = gohelper.findChildButton(arg_1_0.viewGO, "#btn_groupselect")

	arg_1_0:_initLevelItems()

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
	if arg_4_0._id then
		AchievementSelectController.instance:changeNamePlateSelect(arg_4_0._id)

		local var_4_0 = AchievementSelectListModel.instance:isSingleSelected(arg_4_0._id)

		AudioMgr.instance:trigger(var_4_0 and AudioEnum.UI.play_ui_hero_card_click or AudioEnum.UI.play_ui_hero_card_gone)
	end
end

function var_0_0._initLevelItems(arg_5_0)
	arg_5_0.levelItemList = {}

	for iter_5_0 = 1, 3 do
		local var_5_0 = {
			go = gohelper.findChild(arg_5_0._goIcon, "level" .. iter_5_0)
		}

		var_5_0.gobg = gohelper.findChild(var_5_0.go, "#simage_bg")
		var_5_0.simagetitle = gohelper.findChildSingleImage(var_5_0.go, "#simage_title")
		var_5_0.txtlevel = gohelper.findChildText(var_5_0.go, "#txt_level")

		gohelper.setActive(var_5_0.go, false)
		table.insert(arg_5_0.levelItemList, var_5_0)
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._animator = gohelper.onceAddComponent(arg_6_0.viewGO, typeof(UnityEngine.Animator))
end

function var_0_0.onDestroy(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1 and arg_8_1.achievementCfgs[1]
	arg_8_0._achievementId = arg_8_0._mo.achievementId
	arg_8_0._achievementCo = arg_8_0._mo.co
	arg_8_0._id = arg_8_0._mo.taskId
	arg_8_0._co = arg_8_0._mo.taskCo

	arg_8_0:refreshUI()
end

function var_0_0.refreshUI(arg_9_0)
	if not AchievementSelectListModel.instance:checkIsNamePlate() then
		return
	end

	local var_9_0 = AchievementSelectListModel.instance:isSingleSelected(arg_9_0._id)

	gohelper.setActive(arg_9_0._goselect, var_9_0)

	local var_9_1 = arg_9_0.levelItemList[arg_9_0._co.level]
	local var_9_2
	local var_9_3

	if arg_9_0._co.image and not string.nilorempty(arg_9_0._co.image) then
		local var_9_4 = string.split(arg_9_0._co.image, "#")

		var_9_2 = var_9_4[1]
		var_9_3 = var_9_4[2]
	end

	local function var_9_5()
		local var_10_0 = var_9_1._bgLoader:getInstGO()
	end

	var_9_1._bgLoader = PrefabInstantiate.Create(var_9_1.gobg)

	var_9_1._bgLoader:startLoad(AchievementUtils.getBgPrefabUrl(var_9_2), var_9_5, arg_9_0)
	var_9_1.simagetitle:LoadImage(ResUrl.getAchievementLangIcon(var_9_3))

	local var_9_6 = arg_9_0._co.listenerType
	local var_9_7 = AchievementUtils.getAchievementProgressBySourceType(arg_9_0._achievementCo.rule)
	local var_9_8

	if var_9_6 and var_9_6 == "TowerPassLayer" then
		if arg_9_0._co.listenerParam and not string.nilorempty(arg_9_0._co.listenerParam) then
			local var_9_9 = string.split(arg_9_0._co.listenerParam, "#")

			var_9_8 = var_9_9 and var_9_9[3]
			var_9_8 = var_9_8 * 10
		end
	else
		var_9_8 = arg_9_0._co and arg_9_0._co.maxProgress
	end

	var_9_1.txtlevel.text = var_9_8 < var_9_7 and var_9_7 or var_9_8

	gohelper.setActive(arg_9_0.levelItemList[arg_9_0._co.level].go, true)
end

function var_0_0.playAchievementAnim(arg_11_0)
	return
end

function var_0_0._onFocusFinished(arg_12_0)
	return
end

return var_0_0
