module("modules.logic.necrologiststory.view.comp.NecrologistStoryErasePictureComp", package.seeall)

local var_0_0 = class("NecrologistStoryErasePictureComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.transform = arg_1_1.transform
	arg_1_0.imgNormal = gohelper.findChildImage(arg_1_1, "normal")
	arg_1_0.imgMask = gohelper.findChildImage(arg_1_1, "mask")
	arg_1_0.simageNormal = gohelper.findChildSingleImage(arg_1_1, "normal")
	arg_1_0.simageMask = gohelper.findChildSingleImage(arg_1_1, "mask")
	arg_1_0.lockMaterialId = 10
	arg_1_0.normalMatId = 11

	local var_1_0 = IconMaterialMgr.instance:getMaterialPath(arg_1_0.lockMaterialId)

	IconMaterialMgr.instance:loadMaterialAddSet(var_1_0, arg_1_0.imgMask)
end

function var_0_0.setEraseData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._isFinish = false
	arg_2_0.brushSize = arg_2_2
	arg_2_0.finishRate = arg_2_3

	gohelper.setActive(arg_2_0.imgMask, true)
	arg_2_0.simageNormal:LoadImage(arg_2_1, arg_2_0.onNormalLoaded, arg_2_0)
	arg_2_0.simageMask:LoadImage(arg_2_1, arg_2_0.onMaskLoaded, arg_2_0)
end

function var_0_0.onNormalLoaded(arg_3_0)
	ZProj.UGUIHelper.SetImageSize(arg_3_0.simageNormal.gameObject)
end

function var_0_0.onMaskLoaded(arg_4_0)
	ZProj.UGUIHelper.SetImageSize(arg_4_0.simageMask.gameObject)
	arg_4_0:addComp()
end

function var_0_0.addComp(arg_5_0)
	arg_5_0.erasePicture = ZProj.ErasePicture.AddComp(arg_5_0.imgMask.gameObject)

	arg_5_0.erasePicture:setCallBack(arg_5_0.startDraw, arg_5_0, arg_5_0.showRate, arg_5_0, arg_5_0.endDraw, arg_5_0, arg_5_0.finishDraw, arg_5_0)
	arg_5_0.erasePicture:InitData(arg_5_0.brushSize, arg_5_0.finishRate, arg_5_0.imgMask, CameraMgr.instance:getUICamera())
end

function var_0_0.setCallback(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	arg_6_0.startCallback = arg_6_1
	arg_6_0.drawCallback = arg_6_2
	arg_6_0.endCallback = arg_6_3
	arg_6_0.finishCallback = arg_6_4
	arg_6_0.callbackObj = arg_6_5
end

function var_0_0.startDraw(arg_7_0)
	if arg_7_0:isFinish() then
		return
	end

	if arg_7_0.startCallback then
		arg_7_0.startCallback(arg_7_0.callbackObj)
	end
end

function var_0_0.showRate(arg_8_0, arg_8_1)
	if arg_8_0:isFinish() then
		return
	end

	if arg_8_0.drawCallback then
		arg_8_0.drawCallback(arg_8_0.callbackObj, arg_8_1)
	end
end

function var_0_0.endDraw(arg_9_0)
	if arg_9_0:isFinish() then
		return
	end

	if arg_9_0.endCallback then
		arg_9_0.endCallback(arg_9_0.callbackObj)
	end
end

function var_0_0.finishDraw(arg_10_0)
	if arg_10_0:isFinish() then
		return
	end

	gohelper.setActive(arg_10_0.imgMask, false)

	arg_10_0._isFinish = true

	if arg_10_0.finishCallback then
		arg_10_0.finishCallback(arg_10_0.callbackObj)
	end
end

function var_0_0.isFinish(arg_11_0)
	return arg_11_0._isFinish
end

function var_0_0.onDestroy(arg_12_0)
	return
end

return var_0_0
