module("modules.logic.survival.view.map.SurvivalMapBubbleView", package.seeall)

local var_0_0 = class("SurvivalMapBubbleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goBubble = gohelper.findChild(arg_1_0.viewGO, "Bubble")
	arg_1_0._goNormal = gohelper.findChild(arg_1_0.viewGO, "Bubble/normal")
	arg_1_0._txtNormalPlace = gohelper.findChildTextMesh(arg_1_0.viewGO, "Bubble/normal/image_Bubble/#txt_place")
	arg_1_0._txtNormalTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "Bubble/normal/image_Bubble/#txt_place/#txt_time")
	arg_1_0._goSpecial = gohelper.findChild(arg_1_0.viewGO, "Bubble/special")
	arg_1_0._txtSpecialPlace = gohelper.findChildTextMesh(arg_1_0.viewGO, "Bubble/special/image_Bubble/#txt_place")
	arg_1_0._txtSpecialTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "Bubble/special/image_Bubble/#txt_place/#txt_time")
	arg_1_0._txtSpecialDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "Bubble/special/image_Bubble/#txt_dec")
end

function var_0_0.addEvents(arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapCostTimeUpdate, arg_2_0._onCostTimeUpdate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapCostTimeUpdate, arg_3_0._onCostTimeUpdate, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._txtNormalPlace.text = luaLang("survival_mapblockname")
	arg_4_0._pathFollowGo = gohelper.create3d(GameSceneMgr.instance:getCurScene():getSceneContainerGO(), "[follow]")

	local var_4_0 = gohelper.onceAddComponent(arg_4_0._goBubble, typeof(ZProj.UIFollower))
	local var_4_1 = CameraMgr.instance:getMainCamera()
	local var_4_2 = CameraMgr.instance:getUICamera()
	local var_4_3 = ViewMgr.instance:getUIRoot().transform

	var_4_0:Set(var_4_1, var_4_2, var_4_3, arg_4_0._pathFollowGo.transform, 0, 0, 0, 0, 0)
	var_4_0:SetEnable(true)
	arg_4_0:_onCostTimeUpdate()
end

function var_0_0._onCostTimeUpdate(arg_5_0, arg_5_1)
	if arg_5_1 then
		local var_5_0 = SurvivalMapModel.instance:getSceneMo()
		local var_5_1 = arg_5_1[#arg_5_1]
		local var_5_2, var_5_3, var_5_4 = SurvivalHelper.instance:hexPointToWorldPoint(var_5_1.q, var_5_1.r)

		transformhelper.setLocalPos(arg_5_0._pathFollowGo.transform, var_5_2, var_5_3, var_5_4)

		local var_5_5 = var_5_0:getBlockCoByPos(var_5_1)

		gohelper.setActive(arg_5_0._goNormal, not var_5_5)
		gohelper.setActive(arg_5_0._goSpecial, var_5_5)

		local var_5_6 = SurvivalMapModel.instance.showCostTime
		local var_5_7 = math.floor(var_5_6 / 60)
		local var_5_8 = var_5_6 % 60
		local var_5_9 = string.format("%02d:%02d", var_5_7, var_5_8)

		if var_5_5 then
			arg_5_0._txtSpecialPlace.text = var_5_5.name
			arg_5_0._txtSpecialDesc.text = var_5_5.preAttrDesc
			arg_5_0._txtSpecialTime.text = var_5_9
		else
			arg_5_0._txtNormalTime.text = var_5_9
		end
	else
		gohelper.setActive(arg_5_0._goNormal, false)
		gohelper.setActive(arg_5_0._goSpecial, false)
	end
end

function var_0_0.onClose(arg_6_0)
	gohelper.destroy(arg_6_0._pathFollowGo)
end

return var_0_0
