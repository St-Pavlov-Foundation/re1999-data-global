module("modules.logic.commandstation.view.CommandStationMapVersionLogoView", package.seeall)

local var_0_0 = class("CommandStationMapVersionLogoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goVersion = gohelper.findChild(arg_1_0.viewGO, "#go_Version")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._loader = PrefabInstantiate.Create(arg_2_0._goVersion)
	arg_2_0._versionLogoAnimator = nil
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0:addEventCb(CommandStationController.instance, CommandStationEvent.ChangeVersionId, arg_3_0._onChangeVersionId, arg_3_0)
	arg_3_0:_onChangeVersionId()
end

function var_0_0._onChangeVersionId(arg_4_0)
	if arg_4_0._versionLogoAnimator then
		arg_4_0._versionLogoAnimator:Play("close", arg_4_0._closeAnimDone, arg_4_0)

		return
	end

	arg_4_0:_loadVersionLogo()
end

function var_0_0._loadVersionLogo(arg_5_0)
	if not (CommandStationMapModel.instance:getVersionId() ~= CommandStationEnum.AllVersion) then
		return
	end

	arg_5_0._loader:dispose()

	local var_5_0 = CommandStationMapModel.instance:getVersionId()
	local var_5_1 = string.format("ui/viewres/commandstation/commandstation_versionitem_%s.prefab", var_5_0)

	arg_5_0._loader:startLoad(var_5_1, arg_5_0._onLoadedDone, arg_5_0)

	arg_5_0._versionId = var_5_0
end

function var_0_0._onLoadedDone(arg_6_0)
	local var_6_0 = arg_6_0._loader:getInstGO()

	arg_6_0._versionLogoAnimator = var_6_0 and SLFramework.AnimatorPlayer.Get(var_6_0)

	if arg_6_0._versionLogoAnimator then
		arg_6_0._versionLogoAnimator:Play("open", arg_6_0._openAnimDone, arg_6_0)
	end
end

function var_0_0._closeAnimDone(arg_7_0)
	arg_7_0._loader:dispose()

	arg_7_0._versionLogoAnimator = nil

	arg_7_0:_loadVersionLogo()
end

function var_0_0._openAnimDone(arg_8_0)
	return
end

function var_0_0.onClose(arg_9_0)
	return
end

return var_0_0
