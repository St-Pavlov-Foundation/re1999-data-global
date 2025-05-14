module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaMapScene", package.seeall)

local var_0_0 = class("LanShouPaMapScene", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(LanShouPaController.instance, LanShouPaEvent.SetScenePos, arg_2_0._onSetScenePos, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(LanShouPaController.instance, LanShouPaEvent.SetScenePos, arg_3_0._onSetScenePos, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	local var_4_0 = CameraMgr.instance:getSceneRoot()

	arg_4_0._sceneRoot = UnityEngine.GameObject.New("LanShouPaScene")

	gohelper.addChild(var_4_0, arg_4_0._sceneRoot)

	arg_4_0._loader = PrefabInstantiate.Create(arg_4_0._sceneRoot)

	arg_4_0._loader:startLoad("scenes/v2a1_m_s12_lsp_jshd/scenes_prefab/v2a1_m_s12_lsp_background_p.prefab")
	transformhelper.setLocalPos(arg_4_0._sceneRoot.transform, 0, 5.8, 0)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._sceneGos = arg_5_0:getUserDataTb_()

	MainCameraMgr.instance:addView(ViewName.LanShouPaMapView, arg_5_0._initCamera, nil, arg_5_0)
end

function var_0_0._initCamera(arg_6_0)
	local var_6_0 = CameraMgr.instance:getMainCamera()
	local var_6_1 = GameUtil.getAdapterScale(true)

	var_6_0.orthographic = true
	var_6_0.orthographicSize = 7.5 * var_6_1
end

function var_0_0.setSceneVisible(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0._sceneRoot, arg_7_1)
end

function var_0_0._onSetScenePos(arg_8_0, arg_8_1)
	transformhelper.setPosXY(arg_8_0._sceneRoot.transform, arg_8_1, 5.8)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	if arg_10_0._loader then
		arg_10_0._loader:dispose()

		arg_10_0._loader = nil
	end

	if arg_10_0._sceneRoot then
		gohelper.destroy(arg_10_0._sceneRoot)

		arg_10_0._sceneRoot = nil
	end
end

return var_0_0
