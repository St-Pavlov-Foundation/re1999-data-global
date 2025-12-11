module("modules.logic.survival.view.reputation.SurvivalReputationBuildItem", package.seeall)

local var_0_0 = class("SurvivalReputationBuildItem", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.viewGO = arg_2_1
	arg_2_0._txtcamp = gohelper.findChildText(arg_2_0.viewGO, "go_card/#txt_camp")
	arg_2_0._simagebuilding = gohelper.findChildSingleImage(arg_2_0.viewGO, "go_card/#simage_building")
	arg_2_0._txtname = gohelper.findChildText(arg_2_0.viewGO, "go_card/#txt_name")
	arg_2_0._imagecamp = gohelper.findChildImage(arg_2_0.viewGO, "go_card/#image_camp")
	arg_2_0._imagelevelbg = gohelper.findChildImage(arg_2_0.viewGO, "go_card/#image_levelbg")
	arg_2_0._txtlevel = gohelper.findChildText(arg_2_0.viewGO, "go_card/#image_levelbg/#txt_level")
	arg_2_0._imageprogresspre = gohelper.findChildImage(arg_2_0.viewGO, "go_card/score/progress/#image_progress_pre")
	arg_2_0._imageprogress = gohelper.findChildImage(arg_2_0.viewGO, "go_card/score/progress/#image_progress")
	arg_2_0._txtcurrent = gohelper.findChildText(arg_2_0.viewGO, "go_card/score/#txt_current")
	arg_2_0._txtcurrentloop = gohelper.findChildText(arg_2_0.viewGO, "go_card/score/#txt_current_loop")
	arg_2_0._txttotal = gohelper.findChildText(arg_2_0.viewGO, "go_card/score/#txt_total")
	arg_2_0._golevelUp = gohelper.findChild(arg_2_0.viewGO, "go_card/#go_levelUp")
	arg_2_0._goselect = gohelper.findChild(arg_2_0.viewGO, "#go_select")
	arg_2_0._btnclick = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#btn_click")
end

function var_0_0.onStart(arg_3_0)
	return
end

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0:addClickCb(arg_4_0._btnclick, arg_4_0.onClickBtnClick, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	return
end

function var_0_0.onDestroy(arg_6_0)
	return
end

function var_0_0.setData(arg_7_0, arg_7_1)
	arg_7_0.score = arg_7_1.score
	arg_7_0.mo = arg_7_1.mo
	arg_7_0.index = arg_7_1.index
	arg_7_0.onAnimalPlayCallBack = arg_7_1.onAnimalPlayCallBack

	if arg_7_1 == nil then
		gohelper.setActive(arg_7_0.viewGO, false)

		return
	end

	gohelper.setActive(arg_7_0.viewGO, true)

	arg_7_0.buildingCfgId = arg_7_0.mo.buildingId
	arg_7_0.buildCfg = SurvivalConfig.instance:getBuildingConfig(arg_7_0.buildingCfgId, arg_7_0.mo.level)
	arg_7_0.onClickCallBack = arg_7_1.onClickCallBack
	arg_7_0.onClickContext = arg_7_1.onClickContext
	arg_7_0.reputationProp = arg_7_0.mo.survivalReputationPropMo.prop

	arg_7_0:refreshReputationData()
	arg_7_0:refreshNotAnimUI()
	arg_7_0:refreshTextScore()
	arg_7_0:refreshProgress()
	arg_7_0:refreshProgressPre()
	arg_7_0:refreshUpgrade()
end

function var_0_0.refreshReputationData(arg_8_0)
	arg_8_0.survivalReputationPropMo = SurvivalReputationPropMo.New()

	arg_8_0.survivalReputationPropMo:setData(arg_8_0.reputationProp)

	arg_8_0.reputationId = arg_8_0.reputationProp.reputationId
	arg_8_0.reputationCfg = SurvivalConfig.instance:getReputationCfgById(arg_8_0.reputationId, arg_8_0.reputationProp.reputationLevel)
	arg_8_0.reputationType = arg_8_0.reputationCfg.type
	arg_8_0.isMaxLevel = arg_8_0.survivalReputationPropMo:isMaxLevel()
end

function var_0_0.onClickBtnClick(arg_9_0)
	if arg_9_0.onClickCallBack then
		arg_9_0.onClickCallBack(arg_9_0.onClickContext, arg_9_0)
	end
end

function var_0_0.setSelect(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._goselect, arg_10_1)

	arg_10_0.isSelect = arg_10_1

	arg_10_0:refreshProgress()
	arg_10_0:refreshProgressPre()
	arg_10_0:refreshTextScore()
end

function var_0_0.refreshNotAnimUI(arg_11_0)
	arg_11_0._txtcamp.text = arg_11_0.reputationCfg.name

	arg_11_0._simagebuilding:LoadImage(arg_11_0.buildCfg.icon)

	arg_11_0._txtname.text = arg_11_0.buildCfg.name

	UISpriteSetMgr.instance:setSurvivalSprite(arg_11_0._imagecamp, arg_11_0.reputationCfg.icon)

	arg_11_0.reputationLevel = arg_11_0.reputationProp.reputationLevel
	arg_11_0._txtlevel.text = "Lv." .. arg_11_0.reputationLevel
	arg_11_0.curReputation = arg_11_0.reputationProp.reputationExp

	local var_11_0 = arg_11_0.survivalReputationPropMo:getLevelBkg()

	UISpriteSetMgr.instance:setSurvivalSprite2(arg_11_0._imagelevelbg, var_11_0)

	local var_11_1 = arg_11_0.survivalReputationPropMo:getLevelProgressBkg(true)

	UISpriteSetMgr.instance:setSurvivalSprite2(arg_11_0._imageprogresspre, var_11_1)

	local var_11_2 = arg_11_0.survivalReputationPropMo:getLevelProgressBkg()

	UISpriteSetMgr.instance:setSurvivalSprite2(arg_11_0._imageprogress, var_11_2)

	if arg_11_0.isMaxLevel then
		arg_11_0._txttotal.text = "--"
	else
		local var_11_3 = SurvivalConfig.instance:getReputationCost(arg_11_0.reputationId, arg_11_0.reputationLevel)

		arg_11_0._txttotal.text = var_11_3
	end
end

function var_0_0.refreshUpgrade(arg_12_0)
	if arg_12_0.isMaxLevel then
		gohelper.setActive(arg_12_0._golevelUp, false)
	else
		local var_12_0 = SurvivalConfig.instance:getReputationCost(arg_12_0.reputationId, arg_12_0.reputationLevel)

		gohelper.setActive(arg_12_0._golevelUp, var_12_0 <= arg_12_0.score + arg_12_0.curReputation)
	end
end

function var_0_0.refreshProgress(arg_13_0)
	if arg_13_0.isMaxLevel then
		arg_13_0._imageprogress.fillAmount = 0
	else
		local var_13_0 = SurvivalConfig.instance:getReputationCost(arg_13_0.reputationId, arg_13_0.reputationLevel)

		arg_13_0._imageprogress.fillAmount = arg_13_0.curReputation / var_13_0
	end
end

function var_0_0.refreshProgressPre(arg_14_0)
	local var_14_0

	if arg_14_0.isSelect and not arg_14_0.isMaxLevel then
		local var_14_1 = SurvivalConfig.instance:getReputationCost(arg_14_0.reputationId, arg_14_0.reputationLevel)
		local var_14_2 = (arg_14_0.score + arg_14_0.curReputation) / var_14_1

		arg_14_0._imageprogresspre.fillAmount = var_14_2

		gohelper.setActive(arg_14_0._imageprogresspre, true)
	else
		gohelper.setActive(arg_14_0._imageprogresspre, false)
	end
end

function var_0_0.refreshTextScore(arg_15_0)
	if arg_15_0.isMaxLevel then
		arg_15_0._txtcurrent.text = "--"

		gohelper.setActive(arg_15_0._txtcurrentloop, false)
	elseif arg_15_0.isSelect then
		arg_15_0._txtcurrent.text = string.format("%s", arg_15_0.curReputation)
		arg_15_0._txtcurrentloop.text = string.format("(+%s)", arg_15_0.score)

		gohelper.setActive(arg_15_0._txtcurrentloop, true)
	else
		arg_15_0._txtcurrent.text = arg_15_0.curReputation

		gohelper.setActive(arg_15_0._txtcurrentloop, false)
	end
end

function var_0_0.playUpAnim(arg_16_0, arg_16_1)
	local var_16_0, var_16_1 = SurvivalConfig.instance:getReputationCost(arg_16_0.reputationId, arg_16_0.reputationLevel), arg_16_0.curReputation

	arg_16_0.oldPer = var_16_1 / var_16_0

	local var_16_2 = (var_16_1 + arg_16_0.score) / var_16_0

	arg_16_0.isUpgrade = var_16_2 >= 1
	arg_16_0.reputationProp = arg_16_1.reputationProp

	arg_16_0:refreshReputationData()

	local var_16_3 = math.min(var_16_2, 1)
	local var_16_4 = 1.5

	arg_16_0.firstMovePer = var_16_3 - arg_16_0.oldPer

	local var_16_5 = var_16_1 + arg_16_0.score
	local var_16_6 = arg_16_0.reputationProp.reputationLevel

	arg_16_0.secondMovePer = 0

	if arg_16_0.isUpgrade then
		if arg_16_0.isMaxLevel then
			arg_16_0.secondMovePer = 0
		else
			arg_16_0.secondMovePer = arg_16_0.reputationProp.reputationExp / SurvivalConfig.instance:getReputationCost(arg_16_0.reputationId, var_16_6)
		end
	end

	local var_16_7 = FlowSequence.New()

	var_16_7:addWork(TweenWork.New({
		from = 0,
		type = "DOTweenFloat",
		to = arg_16_0.firstMovePer + arg_16_0.secondMovePer,
		t = var_16_4,
		frameCb = arg_16_0._onProgressFloat,
		cbObj = arg_16_0,
		ease = EaseType.OutQuart
	}))
	gohelper.setActive(arg_16_0._imageprogresspre, true)

	arg_16_0._imageprogresspre.fillAmount = var_16_3

	if arg_16_0.isUpgrade then
		var_16_7:addWork(AnimatorWork.New({
			animName = "lvup",
			go = arg_16_0.viewGO
		}))
	end

	local var_16_8 = FlowParallel.New()

	var_16_8:addWork(AnimatorWork.New({
		animName = "scoreup",
		go = arg_16_0.viewGO
	}))
	var_16_8:addWork(TweenWork.New({
		type = "DOTweenFloat",
		from = var_16_1,
		to = var_16_5,
		t = var_16_4,
		frameCb = arg_16_0._onFloat,
		cbObj = arg_16_0,
		ease = EaseType.OutQuart
	}))
	var_16_8:addWork(var_16_7)

	return var_16_8
end

function var_0_0._onProgressFloat(arg_17_0, arg_17_1)
	if arg_17_1 <= arg_17_0.firstMovePer then
		arg_17_0.progresMoveStage = 1
		arg_17_0._imageprogress.fillAmount = arg_17_0.oldPer + arg_17_1
	end

	if arg_17_1 >= arg_17_0.firstMovePer and arg_17_0.isUpgrade and arg_17_0.progresMoveStage == 1 then
		arg_17_0.progresMoveStage = 2

		arg_17_0:_refreshUIState({
			per = arg_17_0.secondMovePer
		})
	end

	if arg_17_1 > arg_17_0.firstMovePer and arg_17_0.isUpgrade then
		arg_17_0._imageprogress.fillAmount = arg_17_1 - arg_17_0.firstMovePer
	end
end

function var_0_0._onFloat(arg_18_0, arg_18_1)
	arg_18_0._txtcurrent.text = string.format("%s", math.floor(arg_18_1))
end

function var_0_0._refreshUIState2(arg_19_0)
	arg_19_0:refreshNotAnimUI()
end

function var_0_0._refreshUIState(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.per

	arg_20_0:refreshNotAnimUI()
	gohelper.setActive(arg_20_0._imageprogresspre, true)

	arg_20_0._imageprogresspre.fillAmount = var_20_0
	arg_20_0._imageprogress.fillAmount = 0

	gohelper.setActive(arg_20_0._golevelUp, false)
end

return var_0_0
