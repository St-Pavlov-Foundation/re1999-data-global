module("modules.logic.versionactivity1_8.dungeon.view.factory.repairgame.VersionActivity1_8FactoryRepairGameMapItem", package.seeall)

local var_0_0 = class("VersionActivity1_8FactoryRepairGameMapItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._contentTrans = arg_1_0._gocontent.transform
	arg_1_0._imageBg = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#image_Bg")

	gohelper.setActive(arg_1_0._imageBg, false)

	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#image_icon")
	arg_1_0._goEffLight = gohelper.findChild(arg_1_0.viewGO, "#go_content/eff_light")
	arg_1_0._effLightAnimator = arg_1_0._goEffLight:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)
	arg_1_0._imageconn = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#image_conn")
	arg_1_0._imageconnTrs = arg_1_0._imageconn.transform
	arg_1_0._imagenum = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#image_num")

	arg_1_0:_playAnim(false, nil)
end

function var_0_0.initItem(arg_2_0, arg_2_1)
	if not arg_2_1 or arg_2_1.typeId == 0 then
		gohelper.setActive(arg_2_0._gocontent, false)

		return
	end

	gohelper.setActive(arg_2_0._gocontent, true)

	local var_2_0 = Activity157RepairGameModel.instance:isPlaceByXY(arg_2_1.x, arg_2_1.y)

	if arg_2_1.typeId == ArmPuzzlePipeEnum.type.zhanwei then
		local var_2_1 = Activity157RepairGameModel.instance:isPlaceSelectXY(arg_2_1.x, arg_2_1.y)

		arg_2_0:_playAnim(var_2_1, var_2_1 and "turngreen" or "turnred")
	else
		arg_2_0:_playAnim(false, nil)
	end

	gohelper.setActive(arg_2_0._imageBg, var_2_0 and arg_2_1.typeId ~= ArmPuzzlePipeEnum.type.zhanwei)

	local var_2_2, var_2_3 = arg_2_1:getBackgroundRes()

	if var_2_3 then
		UISpriteSetMgr.instance:setV1a8FactorySprite(arg_2_0._imageicon, var_2_2, true)
	else
		UISpriteSetMgr.instance:setArmPipeSprite(arg_2_0._imageicon, var_2_2, true)
	end

	local var_2_4 = ArmPuzzlePipeEnum.resNumIcons[arg_2_1.numIndex]

	if arg_2_1:isEntry() then
		if var_2_4 then
			UISpriteSetMgr.instance:setArmPipeSprite(arg_2_0._imagenum, var_2_4, true)
		end
	elseif ArmPuzzlePipeEnum.pathConn[arg_2_1.typeId] then
		local var_2_5, var_2_6 = arg_2_1:getBackgroundRes()

		if var_2_6 then
			UISpriteSetMgr.instance:setV1a8FactorySprite(arg_2_0._imageconn, var_2_5, true)
		else
			UISpriteSetMgr.instance:setArmPipeSprite(arg_2_0._imageconn, var_2_5, true)
		end
	end

	local var_2_7 = (Activity157Enum.entryTypeColor[arg_2_1.typeId] or Activity157Enum.entryColor)[arg_2_1.pathIndex] or Activity157Enum.entryColor[0]

	SLFramework.UGUI.GuiHelper.SetColor(arg_2_0._imagenum, var_2_7)
	SLFramework.UGUI.GuiHelper.SetColor(arg_2_0._imageicon, var_2_7)
	gohelper.setActive(arg_2_0._imagenum, arg_2_1:isEntry() and var_2_4 ~= nil)
	gohelper.setActive(arg_2_0._imageconn, false)
	arg_2_0:syncRotation(arg_2_1)
end

function var_0_0._playAnim(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._lastEffActivie ~= arg_3_1 then
		arg_3_0._lastEffActivie = arg_3_1

		gohelper.setActive(arg_3_0._goEffLight, arg_3_1)
	end

	if arg_3_1 then
		if arg_3_2 and arg_3_0._lastEffActivie ~= arg_3_2 then
			arg_3_0._lastEffActivie = arg_3_2

			arg_3_0._effLightAnimator:Play(arg_3_2)
		end
	else
		arg_3_0._lastEffAnimName = nil
	end
end

function var_0_0.syncRotation(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	local var_4_0 = arg_4_1:getRotation()

	transformhelper.setLocalRotation(arg_4_0._contentTrans, 0, 0, var_4_0)
end

function var_0_0.initConnectObj(arg_5_0, arg_5_1)
	local var_5_0 = false

	if arg_5_1 then
		if ArmPuzzlePipeEnum.pathConn[arg_5_1.typeId] then
			var_5_0 = arg_5_1:getConnectValue() ~= 0
		elseif ArmPuzzlePipeEnum.type.wrong == arg_5_1.typeId then
			local var_5_1
			local var_5_2

			if arg_5_1:getConnectValue() >= 2 then
				var_5_1, var_5_2 = arg_5_1:getConnectRes()
			else
				var_5_1, var_5_2 = arg_5_1:getBackgroundRes()
			end

			if var_5_2 then
				UISpriteSetMgr.instance:setV1a8FactorySprite(arg_5_0._imageicon, var_5_1, true)
			else
				UISpriteSetMgr.instance:setArmPipeSprite(arg_5_0._imageicon, var_5_1, true)
			end
		end

		if var_5_0 then
			local var_5_3, var_5_4 = arg_5_0:_getConnectParam(arg_5_1)
			local var_5_5, var_5_6 = ArmPuzzleHelper.getConnectRes(var_5_3, Activity157Enum.res)

			if var_5_6 then
				UISpriteSetMgr.instance:setV1a8FactorySprite(arg_5_0._imageconn, var_5_5, true)
			else
				UISpriteSetMgr.instance:setArmPipeSprite(arg_5_0._imageconn, var_5_5, true)
			end

			SLFramework.UGUI.GuiHelper.SetColor(arg_5_0._imageconn, Activity157Enum.pathColor[arg_5_1.connectPathIndex] or "#FFFFFF")
			transformhelper.setLocalRotation(arg_5_0._imageconnTrs, 0, 0, var_5_4)
		end
	end

	gohelper.setActive(arg_5_0._imageconn, var_5_0)
end

function var_0_0._getConnectParam(arg_6_0, arg_6_1)
	if ArmPuzzlePipeEnum.type.t_shape == arg_6_1.typeId then
		local var_6_0 = arg_6_1:getConnectValue()

		for iter_6_0, iter_6_1 in pairs(ArmPuzzlePipeEnum.rotate) do
			if iter_6_1[var_6_0] then
				local var_6_1 = ArmPuzzleHelper.getRotation(iter_6_0, var_6_0) - arg_6_1:getRotation()

				return iter_6_0, var_6_1
			end
		end
	end

	return arg_6_1.typeId, 0
end

function var_0_0.onDestroy(arg_7_0)
	return
end

return var_0_0
