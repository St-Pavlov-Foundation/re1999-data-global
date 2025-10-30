module("modules.logic.versionactivity3_0.karong.view.comp.KaRongDrawObjAlert", package.seeall)

local var_0_0 = class("KaRongDrawObjAlert", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.image = gohelper.findChildImage(arg_1_0.go, "#image_content")
	arg_1_0.imageTf = arg_1_0.image.transform
	arg_1_0.tf = arg_1_0.go.transform

	UISpriteSetMgr.instance:setPuzzleSprite(arg_1_0.image, KaRongDrawEnum.MazeAlertResPath, true)
end

function var_0_0.onInit(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.mo = arg_2_1
end

function var_0_0.onEnable(arg_3_0, arg_3_1, arg_3_2)
	gohelper.setActive(arg_3_0.go, true)
	gohelper.setAsLastSibling(arg_3_0.go)

	local var_3_0 = string.splitToNumber(arg_3_2, "_")

	if arg_3_1 == KaRongDrawEnum.MazeAlertType.VisitBlock or arg_3_1 == KaRongDrawEnum.MazeAlertType.DisconnectLine then
		local var_3_1, var_3_2 = KaRongDrawModel.instance:getLineAnchor(var_3_0[1], var_3_0[2], var_3_0[3], var_3_0[4])

		recthelper.setAnchor(arg_3_0.tf, var_3_1 + KaRongDrawEnum.MazeAlertBlockOffsetX, var_3_2 + KaRongDrawEnum.MazeAlertBlockOffsetY)
	elseif arg_3_1 == KaRongDrawEnum.MazeAlertType.VisitRepeat then
		local var_3_3, var_3_4 = KaRongDrawModel.instance:getObjectAnchor(var_3_0[1], var_3_0[2])

		recthelper.setAnchor(arg_3_0.tf, var_3_3 + KaRongDrawEnum.MazeAlertCrossOffsetX, var_3_4 + KaRongDrawEnum.MazeAlertCrossOffsetY)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Act176_ForbiddenGo)
end

function var_0_0.onDisable(arg_4_0)
	gohelper.setActive(arg_4_0.go, false)
end

function var_0_0.destroy(arg_5_0)
	arg_5_0:__onDispose()
end

return var_0_0
