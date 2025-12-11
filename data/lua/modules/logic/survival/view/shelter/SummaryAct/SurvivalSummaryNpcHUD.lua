module("modules.logic.survival.view.shelter.SummaryAct.SurvivalSummaryNpcHUD", package.seeall)

local var_0_0 = class("SurvivalSummaryNpcHUD", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entityGO = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.viewGO = arg_2_1
	arg_2_0._animroot = gohelper.findChildAnim(arg_2_0.viewGO, "root")
	arg_2_0._imagebubble = gohelper.findChildImage(arg_2_0.viewGO, "root/#image_bubble")
	arg_2_0._imageicon = gohelper.findChildImage(arg_2_0.viewGO, "root/#image_icon")
	arg_2_0._goInfo = gohelper.findChild(arg_2_0.viewGO, "root/#go_Info")
	arg_2_0._animgoinfo = arg_2_0._goInfo:GetComponent(gohelper.Type_Animation)
	arg_2_0._txtInfo = gohelper.findChildText(arg_2_0.viewGO, "root/#go_Info/Info/#txt_Info")
	arg_2_0._imagelevel = gohelper.findChildImage(arg_2_0.viewGO, "root/#go_Info/Info/#txt_Info/#image_level")
	arg_2_0._goreddot = gohelper.findChild(arg_2_0.viewGO, "root/#go_Info/Info/#txt_Info/#go_reddot")
	arg_2_0._txtadd = gohelper.findChildText(arg_2_0.viewGO, "root/#go_Info/Info/#txt_Info/#txt_add")
	arg_2_0.txt_name = gohelper.findChildText(arg_2_0.viewGO, "root/#go_Info/#txt_name")
	arg_2_0.trans = arg_2_1.transform

	transformhelper.setLocalPos(arg_2_0.trans, 9999, 9999, 0)

	local var_2_0 = CameraMgr.instance:getMainCamera()
	local var_2_1 = CameraMgr.instance:getUICamera()
	local var_2_2 = ViewMgr.instance:getUIRoot().transform

	gohelper.setActive(arg_2_0._goarrow, false)

	arg_2_0._uiFollower = gohelper.onceAddComponent(arg_2_0.viewGO, typeof(ZProj.UIFollower))

	arg_2_0._uiFollower:Set(var_2_0, var_2_1, var_2_2, arg_2_0.entityGO.transform, 0, 1.1, 0, 0, 0)
	arg_2_0._uiFollower:SetEnable(true)
end

function var_0_0.addEventListeners(arg_3_0)
	return
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0.playCloseAnim(arg_5_0)
	arg_5_0._animroot:Play(UIAnimationName.Close)
end

function var_0_0.onDestroy(arg_6_0)
	if arg_6_0.textTweenId then
		ZProj.TweenHelper.KillById(arg_6_0.textTweenId)

		arg_6_0.textTweenId = nil
	end
end

function var_0_0.setData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.npcId = arg_7_1
	arg_7_0.upInfo = arg_7_2
	arg_7_0.npcCfg = SurvivalConfig.instance:getNpcConfig(arg_7_0.npcId)
	arg_7_0.reputationId = SurvivalConfig.instance:getNpcRenown(arg_7_0.npcId)[1]
	arg_7_0.weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	arg_7_0.reputationLevel = arg_7_0.weekInfo:getBuildingMoByReputationId(arg_7_0.reputationId).survivalReputationPropMo.prop.reputationLevel
	arg_7_0.reputationCfg = SurvivalConfig.instance:getReputationCfgById(arg_7_0.reputationId, arg_7_0.reputationLevel)

	local var_7_0 = arg_7_0.reputationCfg.type
	local var_7_1 = SurvivalUnitIconHelper.instance:getRelationIcon(var_7_0)

	UISpriteSetMgr.instance:setSurvivalSprite(arg_7_0._imageicon, var_7_1)

	arg_7_0.txt_name.text = arg_7_0.npcCfg.name
	arg_7_0._txtInfo.text = arg_7_0.reputationCfg.name

	local var_7_2 = string.format("survival_level_icon_%s", arg_7_0.reputationLevel)

	UISpriteSetMgr.instance:setSurvivalSprite(arg_7_0._imagelevel, var_7_2)

	arg_7_0.endValue, arg_7_0.startValue = SurvivalConfig.instance:getNpcReputationValue(arg_7_0.npcId), 0
	arg_7_0._txtadd.text = string.format("+%s", arg_7_0.startValue)
	arg_7_0.textTweenId = ZProj.TweenHelper.DOTweenFloat(arg_7_0.startValue, arg_7_0.endValue, 2, arg_7_0.setPercentValue, arg_7_0.onTweenFinish, arg_7_0, nil, EaseType.OutQuart)

	if arg_7_0.upInfo then
		arg_7_0._animgoinfo:Play()
	end
end

function var_0_0.setPercentValue(arg_8_0, arg_8_1)
	local var_8_0 = string.format("+%s", math.floor(arg_8_1))

	arg_8_0._txtadd.text = var_8_0
end

function var_0_0.onTweenFinish(arg_9_0)
	arg_9_0:setPercentValue(arg_9_0.endValue)
end

return var_0_0
