module("modules.common.preload.ConstResLoader", package.seeall)

slot0 = class("ConstResLoader")

function slot0.ctor(slot0)
	slot0._loadFuncList = {
		slot0._initLive2d,
		slot0._loadConstAb,
		slot0._loadIconPrefab,
		slot0._loadAvProPrefab,
		slot0._loadUIBlockAnim,
		slot0._loadLoadingUIBg
	}
	slot0._loadIndex = nil
	slot0._finishCb = nil
	slot0._finishCbObj = nil
end

function slot0.startLoad(slot0, slot1, slot2)
	slot0._loadIndex = 0
	slot0._finishCb = slot1
	slot0._finishCbObj = slot2

	slot0:_loadShader()
end

function slot0._loadShader(slot0)
	ShaderCache.instance:init(slot0._onShaderLoadFinish, slot0)
end

function slot0._onShaderLoadFinish(slot0)
	BootLoadingView.instance:show(0.6, booterLang("loading_res"))
	slot0:_startLoadOthers()
end

function slot0._startLoadOthers(slot0)
	for slot4, slot5 in ipairs(slot0._loadFuncList) do
		slot5(slot0)

		slot0._loadIndex = slot0._loadIndex + 1
	end
end

function slot0._onLoadFinish(slot0)
	slot1 = #slot0._loadFuncList

	BootLoadingView.instance:show(0.6 + 0.25 * (slot1 - slot0._loadIndex) / slot1, booterLang("loading_res"))

	slot0._loadIndex = slot0._loadIndex - 1

	if slot0._loadIndex == 0 then
		slot0._finishCb(slot0._finishCbObj)
	end
end

function slot0._initLive2d(slot0)
	if GameResMgr.IsFromEditorDir then
		slot0:_onLoadFinish()
	else
		ZProj.Live2dHelper.Init(slot0._onLoadFinish, slot0)
	end
end

function slot0._loadConstAb(slot0)
	ConstAbCache.instance:startLoad(slot0._onLoadFinish, slot0)
end

function slot0._loadIconPrefab(slot0)
	IconMgr.instance:preload(slot0._onLoadFinish, slot0)
end

function slot0._loadAvProPrefab(slot0)
	AvProMgr.instance:preload(slot0._onLoadFinish, slot0)
end

function slot0._loadUIBlockAnim(slot0)
	UIBlockMgrExtend.preload(slot0._onLoadFinish, slot0)
end

slot0.instance = slot0.New()

return slot0
