module("modules.logic.versionactivity3_1.yeshumei.view.YeShuMeiPointItem", package.seeall)

local var_0_0 = class("YeShuMeiPointItem", ListScrollCellExtend)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._tr = arg_1_1.transform

	arg_1_0:initPos(0, 0)
	gohelper.setActive(arg_1_0.go, true)

	arg_1_0._gonormal = gohelper.findChild(arg_1_1, "#go_normal")
	arg_1_0._godisturb = gohelper.findChild(arg_1_1, "#go_disturb")
	arg_1_0._goconnected = gohelper.findChild(arg_1_1, "#go_connected")
	arg_1_0._gofirst = gohelper.findChild(arg_1_1, "#go_fristpoint")
	arg_1_0._click = gohelper.getClickWithDefaultAudio(arg_1_0.go)
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.initPos(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._localPosX = arg_4_1
	arg_4_0._localPosY = arg_4_2

	transformhelper.setLocalPosXY(arg_4_0._tr, arg_4_1, arg_4_2)
end

function var_0_0.getLocalPos(arg_5_0)
	return arg_5_0._localPosX, arg_5_0._localPosY
end

function var_0_0.updateInfo(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	arg_6_0._mo = arg_6_1
	arg_6_0.id = arg_6_1.id
	arg_6_0.typeId = arg_6_1.typeId
	arg_6_0.posX = arg_6_1.posX
	arg_6_0.posY = arg_6_1.posY

	arg_6_0:initPos(arg_6_0.posX, arg_6_0.posY)
	arg_6_0:updateUI()
end

function var_0_0.updateUI(arg_7_0)
	local var_7_0 = YeShuMeiGameModel.instance:getStartPointIds()

	if var_7_0 then
		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			if arg_7_0.id == iter_7_1 then
				arg_7_0._isStart = true

				break
			else
				arg_7_0._isStart = false
			end
		end
	end

	if arg_7_0._mo.state == YeShuMeiEnum.StateType.Normal then
		gohelper.setActive(arg_7_0._gonormal, not arg_7_0._isStart)
		gohelper.setActive(arg_7_0._gofirst, arg_7_0._isStart)
		gohelper.setActive(arg_7_0._goconnected, false)
		gohelper.setActive(arg_7_0._godisturb, false)
	elseif arg_7_0._mo.state == YeShuMeiEnum.StateType.Connect then
		gohelper.setActive(arg_7_0._gonormal, not arg_7_0._isStart)
		gohelper.setActive(arg_7_0._gofirst, arg_7_0._isStart)
		gohelper.setActive(arg_7_0._goconnected, true)
		gohelper.setActive(arg_7_0._godisturb, false)
	else
		gohelper.setActive(arg_7_0._gofirst, false)
		gohelper.setActive(arg_7_0._gonormal, false)
		gohelper.setActive(arg_7_0._goconnected, false)
		gohelper.setActive(arg_7_0._godisturb, true)
	end
end

function var_0_0.checkIsStartPoint(arg_8_0)
	return arg_8_0.isStart
end

function var_0_0.clearPoint(arg_9_0)
	arg_9_0.id = 0
	arg_9_0.typeId = 1
	arg_9_0.posX = 0
	arg_9_0.posY = 0

	arg_9_0:initPos(arg_9_0.posX, arg_9_0.posY)
	gohelper.setActive(arg_9_0.go, false)
end

function var_0_0.onClick(arg_10_0)
	if arg_10_0._mo == nil then
		return
	end

	YeShuMeiGameController.instance:dispatchEvent(YeShuMeiEvent.OnClickPoint, arg_10_0._mo:getId())
end

function var_0_0.checkPointId(arg_11_0, arg_11_1)
	return arg_11_1 == arg_11_0.id
end

function var_0_0.onDestroy(arg_12_0)
	arg_12_0:clearPoint()
end

return var_0_0
