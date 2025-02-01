module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaMainScene", package.seeall)

slot0 = class("TianShiNaNaMainScene", TianShiNaNaBaseSceneView)

function slot0.addEvents(slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.DragMainScene, slot0._onSetScenePos, slot0)
end

function slot0.removeEvents(slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.DragMainScene, slot0._onSetScenePos, slot0)
end

function slot0.getScenePath(slot0)
	return "scenes/v2a2_m_s12_tsnn_jshd/scenes_prefab/v2a2_m_s12_tsnn_jshd_background_p.prefab"
end

function slot0._onSetScenePos(slot0, slot1)
	transformhelper.setPosXY(slot0._sceneRoot.transform, slot1 + 16.14, 6.63)
end

return slot0
