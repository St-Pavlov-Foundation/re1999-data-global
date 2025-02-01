module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaMapScene", package.seeall)

slot0 = class("LanShouPaMapScene", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(LanShouPaController.instance, LanShouPaEvent.SetScenePos, slot0._onSetScenePos, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(LanShouPaController.instance, LanShouPaEvent.SetScenePos, slot0._onSetScenePos, slot0)
end

function slot0._editableInitView(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New("LanShouPaScene")

	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)

	slot0._loader = PrefabInstantiate.Create(slot0._sceneRoot)

	slot0._loader:startLoad("scenes/v2a1_m_s12_lsp_jshd/scenes_prefab/v2a1_m_s12_lsp_background_p.prefab")
	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, 5.8, 0)
end

function slot0.onOpen(slot0)
	slot0._sceneGos = slot0:getUserDataTb_()

	MainCameraMgr.instance:addView(ViewName.LanShouPaMapView, slot0._initCamera, nil, slot0)
end

function slot0._initCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographic = true
	slot1.orthographicSize = 7.5 * GameUtil.getAdapterScale(true)
end

function slot0.setSceneVisible(slot0, slot1)
	gohelper.setActive(slot0._sceneRoot, slot1)
end

function slot0._onSetScenePos(slot0, slot1)
	transformhelper.setPosXY(slot0._sceneRoot.transform, slot1, 5.8)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	if slot0._sceneRoot then
		gohelper.destroy(slot0._sceneRoot)

		slot0._sceneRoot = nil
	end
end

return slot0
