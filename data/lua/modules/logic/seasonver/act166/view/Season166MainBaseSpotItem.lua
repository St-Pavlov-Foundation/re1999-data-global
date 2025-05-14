module("modules.logic.seasonver.act166.view.Season166MainBaseSpotItem", package.seeall)

local var_0_0 = class("Season166MainBaseSpotItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.param = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0:__onInit()

	arg_2_0.go = arg_2_1
	arg_2_0.actId = arg_2_0.param.actId
	arg_2_0.baseId = arg_2_0.param.baseId
	arg_2_0.config = arg_2_0.param.config
	arg_2_0.txtName = gohelper.findChildText(arg_2_0.go, "txt_name")
	arg_2_0.txtTitle = gohelper.findChildText(arg_2_0.go, "txt_title")
	arg_2_0.goStars = gohelper.findChild(arg_2_0.go, "go_stars")
	arg_2_0.btnClick = gohelper.findChildButtonWithAudio(arg_2_0.go, "btn_click")

	local var_2_0 = Season166Config.instance:getSeasonScoreCos(arg_2_0.actId)

	arg_2_0.finalLevelScore = var_2_0[#var_2_0].needScore
	arg_2_0.starTab = arg_2_0:getUserDataTb_()

	for iter_2_0 = 1, 3 do
		local var_2_1 = {
			star = gohelper.findChild(arg_2_0.goStars, "go_star" .. iter_2_0)
		}

		var_2_1.dark = gohelper.findChild(var_2_1.star, "dark")
		var_2_1.light = gohelper.findChild(var_2_1.star, "light")
		var_2_1.imageLight = gohelper.findChildImage(var_2_1.star, "light")
		var_2_1.imageLight1 = gohelper.findChildImage(var_2_1.star, "light/light1")

		table.insert(arg_2_0.starTab, var_2_1)
	end
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0.btnClick:AddClickListener(arg_3_0.onClickBaseSpotItem, arg_3_0)
end

function var_0_0.onClickBaseSpotItem(arg_4_0)
	local var_4_0 = {
		actId = arg_4_0.actId,
		baseId = arg_4_0.baseId,
		config = arg_4_0.config,
		viewType = Season166Enum.WordBaseSpotType
	}

	Season166Controller.instance:openSeasonBaseSpotView(var_4_0)
end

function var_0_0.refreshUI(arg_5_0)
	arg_5_0.txtName.text = arg_5_0.config.name
	arg_5_0.txtTitle.text = string.format("St.%d", arg_5_0.baseId)

	local var_5_0 = Season166BaseSpotModel.instance:getStarCount(arg_5_0.actId, arg_5_0.baseId)
	local var_5_1 = Season166BaseSpotModel.instance:getBaseSpotMaxScore(arg_5_0.actId, arg_5_0.baseId)

	for iter_5_0 = 1, #arg_5_0.starTab do
		gohelper.setActive(arg_5_0.starTab[iter_5_0].light, iter_5_0 <= var_5_0)
		gohelper.setActive(arg_5_0.starTab[iter_5_0].dark, var_5_0 < iter_5_0)

		local var_5_2 = var_5_1 >= arg_5_0.finalLevelScore and "season166_result_inclinedbulb3" or "season166_result_inclinedbulb2"

		UISpriteSetMgr.instance:setSeason166Sprite(arg_5_0.starTab[iter_5_0].imageLight, var_5_2)
		UISpriteSetMgr.instance:setSeason166Sprite(arg_5_0.starTab[iter_5_0].imageLight1, var_5_2)
	end
end

function var_0_0.removeEventListeners(arg_6_0)
	arg_6_0.btnClick:RemoveClickListener()
end

function var_0_0.destroy(arg_7_0)
	arg_7_0:__onDispose()
end

return var_0_0
