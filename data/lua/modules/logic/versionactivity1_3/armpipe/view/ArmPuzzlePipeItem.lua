module("modules.logic.versionactivity1_3.armpipe.view.ArmPuzzlePipeItem", package.seeall)

local var_0_0 = class("ArmPuzzlePipeItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._imageBg = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#image_Bg")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#image_icon")
	arg_1_0._imagenum = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#image_num")
	arg_1_0._imageconn = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#image_conn")
	arg_1_0.tf = arg_1_0._gocontent.transform

	arg_1_0:_editableInitView()
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.onStart(arg_4_0)
	return
end

function var_0_0.onDestroy(arg_5_0)
	return
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._goEffLight = gohelper.findChild(arg_6_0.viewGO, "#go_content/eff_light")
	arg_6_0._effLightAnimator = arg_6_0._goEffLight:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)
	arg_6_0._imageconnTrs = arg_6_0._imageconn.transform

	arg_6_0:_playAnim(false, nil)
	gohelper.setActive(arg_6_0._imageBg, false)
end

function var_0_0.initItem(arg_7_0, arg_7_1)
	if not arg_7_1 or arg_7_1.typeId == 0 then
		gohelper.setActive(arg_7_0._gocontent, false)

		return
	end

	gohelper.setActive(arg_7_0._gocontent, true)

	local var_7_0 = ArmPuzzlePipeModel.instance:isPlaceByXY(arg_7_1.x, arg_7_1.y)

	if arg_7_1.typeId == ArmPuzzlePipeEnum.type.zhanwei then
		local var_7_1 = ArmPuzzlePipeModel.instance:isPlaceSelectXY(arg_7_1.x, arg_7_1.y)

		arg_7_0:_playAnim(var_7_1, var_7_1 and "turngreen" or "turnred")
	else
		arg_7_0:_playAnim(false, nil)
	end

	gohelper.setActive(arg_7_0._imageBg, var_7_0 and arg_7_1.typeId ~= ArmPuzzlePipeEnum.type.zhanwei)
	UISpriteSetMgr.instance:setArmPipeSprite(arg_7_0._imageicon, arg_7_1:getBackgroundRes(), true)

	local var_7_2 = ArmPuzzlePipeEnum.resNumIcons[arg_7_1.numIndex]

	if arg_7_1:isEntry() then
		if var_7_2 then
			UISpriteSetMgr.instance:setArmPipeSprite(arg_7_0._imagenum, var_7_2, true)
		end
	elseif ArmPuzzlePipeEnum.pathConn[arg_7_1.typeId] then
		UISpriteSetMgr.instance:setArmPipeSprite(arg_7_0._imageconn, arg_7_1:getConnectRes(), true)
	end

	local var_7_3 = (ArmPuzzlePipeEnum.entryTypeColor[arg_7_1.typeId] or ArmPuzzlePipeEnum.entryColor)[arg_7_1.pathIndex] or ArmPuzzlePipeEnum.entryColor[0]

	SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._imagenum, var_7_3)
	SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._imageicon, var_7_3)
	gohelper.setActive(arg_7_0._imagenum, arg_7_1:isEntry() and var_7_2 ~= nil)
	gohelper.setActive(arg_7_0._imageconn, false)
	arg_7_0:syncRotation(arg_7_1)
end

function var_0_0._getEntryColor(arg_8_0, arg_8_1)
	local var_8_0

	if arg_8_1.typeId ~= ArmPuzzlePipeEnum.type.first and arg_8_1.typeId == ArmPuzzlePipeEnum.type.last then
		-- block empty
	end

	return var_8_0 or "#FFFFFF"
end

function var_0_0._playAnim(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._lastEffActivie ~= arg_9_1 then
		arg_9_0._lastEffActivie = arg_9_1

		gohelper.setActive(arg_9_0._goEffLight, arg_9_1)
	end

	if arg_9_1 then
		if arg_9_2 and arg_9_0._lastEffActivie ~= arg_9_2 then
			arg_9_0._lastEffActivie = arg_9_2

			arg_9_0._effLightAnimator:Play(arg_9_2)
		end
	else
		arg_9_0._lastEffAnimName = nil
	end
end

function var_0_0.initConnectObj(arg_10_0, arg_10_1)
	local var_10_0 = false

	if arg_10_1 then
		if ArmPuzzlePipeEnum.pathConn[arg_10_1.typeId] then
			var_10_0 = arg_10_1:getConnectValue() ~= 0
		elseif ArmPuzzlePipeEnum.type.wrong == arg_10_1.typeId then
			local var_10_1 = arg_10_1:getConnectValue() >= 2 and arg_10_1:getConnectRes() or arg_10_1:getBackgroundRes()

			UISpriteSetMgr.instance:setArmPipeSprite(arg_10_0._imageicon, var_10_1, true)
		end

		if var_10_0 then
			local var_10_2, var_10_3 = arg_10_0:_getConnectParam(arg_10_1)

			UISpriteSetMgr.instance:setArmPipeSprite(arg_10_0._imageconn, ArmPuzzleHelper.getConnectRes(var_10_2), true)
			SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._imageconn, ArmPuzzlePipeEnum.pathColor[arg_10_1.connectPathIndex] or "#FFFFFF")
			transformhelper.setLocalRotation(arg_10_0._imageconnTrs, 0, 0, var_10_3)
		end
	end

	gohelper.setActive(arg_10_0._imageconn, var_10_0)
end

function var_0_0._getConnectParam(arg_11_0, arg_11_1)
	if ArmPuzzlePipeEnum.type.t_shape == arg_11_1.typeId then
		local var_11_0 = arg_11_1:getConnectValue()

		for iter_11_0, iter_11_1 in pairs(ArmPuzzlePipeEnum.rotate) do
			if iter_11_1[var_11_0] then
				local var_11_1 = ArmPuzzleHelper.getRotation(iter_11_0, var_11_0) - arg_11_1:getRotation()

				return iter_11_0, var_11_1
			end
		end
	end

	return arg_11_1.typeId, 0
end

function var_0_0.syncRotation(arg_12_0, arg_12_1)
	if arg_12_1 then
		local var_12_0 = arg_12_1:getRotation()

		transformhelper.setLocalRotation(arg_12_0.tf, 0, 0, var_12_0)
	end
end

var_0_0.prefabPath = "ui/viewres/versionactivity_1_3/v1a3_arm/v1a3_armpuzzleitem.prefab"

return var_0_0
