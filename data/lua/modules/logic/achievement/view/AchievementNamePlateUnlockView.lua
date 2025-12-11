module("modules.logic.achievement.view.AchievementNamePlateUnlockView", package.seeall)

local var_0_0 = class("AchievementNamePlateUnlockView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goIcon = gohelper.findChild(arg_1_0.viewGO, "go_icon")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")

	arg_1_0:_initLevelItems()

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._initLevelItems(arg_4_0)
	arg_4_0.levelItemList = {}

	for iter_4_0 = 1, 3 do
		local var_4_0 = {
			go = gohelper.findChild(arg_4_0._goIcon, "deep" .. iter_4_0)
		}

		var_4_0.gobg = gohelper.findChild(var_4_0.go, "#simage_bg")
		var_4_0.simagetitle = gohelper.findChildSingleImage(var_4_0.go, "#simage_title")
		var_4_0.txtlevel = gohelper.findChildText(var_4_0.go, "#txt_deep_" .. iter_4_0)

		gohelper.setActive(var_4_0.go, false)
		table.insert(arg_4_0.levelItemList, var_4_0)
	end
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._co = arg_5_0.viewParam
	arg_5_0._id = arg_5_0._co.achievementId

	AudioMgr.instance:trigger(AudioEnum3_1.play_ui_mingdi_success_unlock)
	arg_5_0:refreshUI()
end

function var_0_0.refreshUI(arg_6_0)
	local var_6_0 = arg_6_0._co.level
	local var_6_1 = arg_6_0.levelItemList[var_6_0]
	local var_6_2
	local var_6_3

	if arg_6_0._co.image and not string.nilorempty(arg_6_0._co.image) then
		local var_6_4 = string.split(arg_6_0._co.image, "#")

		var_6_2 = var_6_4[1]
		var_6_3 = var_6_4[2]
	end

	local function var_6_5()
		local var_7_0 = var_6_1._bgLoader:getInstGO()
	end

	var_6_1._bgLoader = PrefabInstantiate.Create(var_6_1.gobg)

	var_6_1._bgLoader:startLoad(AchievementUtils.getBgPrefabUrl(var_6_2), var_6_5, arg_6_0)
	var_6_1.simagetitle:LoadImage(ResUrl.getAchievementLangIcon(var_6_3))

	local var_6_6 = arg_6_0._co.listenerType

	if var_6_6 and var_6_6 == "TowerPassLayer" then
		if arg_6_0._co.listenerParam and not string.nilorempty(arg_6_0._co.listenerParam) then
			local var_6_7 = string.split(arg_6_0._co.listenerParam, "#")
			local var_6_8 = (var_6_7 and var_6_7[3]) * 10

			var_6_1.txtlevel.text = var_6_8
		end
	else
		var_6_1.txtlevel.text = arg_6_0._co and arg_6_0._co.maxProgress
	end

	gohelper.setActive(var_6_1.go, true)
end

function var_0_0._btnCloseOnClick(arg_8_0)
	arg_8_0:closeThis()
end

return var_0_0
