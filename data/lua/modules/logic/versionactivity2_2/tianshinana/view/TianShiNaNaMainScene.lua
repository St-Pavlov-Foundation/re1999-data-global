module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaMainScene", package.seeall)

local var_0_0 = class("TianShiNaNaMainScene", TianShiNaNaBaseSceneView)

function var_0_0.addEvents(arg_1_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.DragMainScene, arg_1_0._onSetScenePos, arg_1_0)
end

function var_0_0.removeEvents(arg_2_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.DragMainScene, arg_2_0._onSetScenePos, arg_2_0)
end

function var_0_0.getScenePath(arg_3_0)
	return "scenes/v2a2_m_s12_tsnn_jshd/scenes_prefab/v2a2_m_s12_tsnn_jshd_background_p.prefab"
end

function var_0_0._onSetScenePos(arg_4_0, arg_4_1)
	transformhelper.setPosXY(arg_4_0._sceneRoot.transform, arg_4_1 + 16.14, 6.63)
end

return var_0_0
