module("modules.logic.weather.eggs.SceneEggTv", package.seeall)

slot0 = class("SceneEggTv", SceneBaseEgg)

function slot0._onEnable(slot0)
	gohelper.setActive(slot0._go, false)
	slot0:_showIcon()
end

function slot0._onDisable(slot0)
	if slot0._srcLoader then
		slot0._srcLoader:dispose()

		slot0._srcLoader = nil
	end

	gohelper.setActive(slot0._go, false)
	slot0:_openAnim(false)
end

function slot0._openAnim(slot0, slot1)
	if slot1 then
		gohelper.setActive(slot0._goWhite, true)

		if slot0._whiteAnimator and slot0._whiteAnimator.isActiveAndEnabled then
			slot0._whiteAnimator:Play("open", slot0._onAnimDone, slot0)
		else
			gohelper.setActive(slot0._goWhite, false)
		end
	elseif slot0._isOpenAnim then
		gohelper.setActive(slot0._goWhite, true)

		if slot0._whiteAnimator and slot0._whiteAnimator.isActiveAndEnabled then
			slot0._whiteAnimator:Play("close", slot0._onAnimDone, slot0)
		else
			gohelper.setActive(slot0._goWhite, false)
		end
	else
		gohelper.setActive(slot0._goWhite, false)
	end

	slot0._isOpenAnim = slot1
end

function slot0._onAnimDone(slot0)
	gohelper.setActive(slot0._goWhite, false)
end

function slot0._onInit(slot0)
	slot0._go = slot0._goList[1]
	slot0._goWhite = slot0._goList[2]
	slot0._whiteAnimator = SLFramework.AnimatorPlayer.Get(slot0._goWhite)

	if not slot0._whiteAnimator then
		logError("SceneEggTv white animator is null")
	end

	gohelper.setActive(slot0._goWhite, false)
	gohelper.setActive(slot0._go, false)

	slot0._iconIndex = 1

	slot0:_initIconId()

	slot1 = slot0._go:GetComponent(typeof(UnityEngine.MeshRenderer))
	slot0._mat = UnityEngine.Object.Instantiate(slot1.sharedMaterial)
	slot1.material = slot0._mat
end

function slot0._initIconId(slot0)
	slot0._iconList = {
		0
	}

	for slot4, slot5 in ipairs(lua_loading_icon.configList) do
		table.insert(slot0._iconList, slot5.id)
	end
end

function slot0._showIcon(slot0)
	if slot0._srcLoader then
		slot0._srcLoader:dispose()

		slot0._srcLoader = nil
	end

	slot1 = slot0:_getRandomIcon()
	slot0._iconUrl = slot1
	slot0._srcLoader = MultiAbLoader.New()

	slot0._srcLoader:addPath(slot1)
	slot0._srcLoader:startLoad(slot0._onLoadIconComplete, slot0)
end

function slot0._onLoadIconComplete(slot0)
	if slot0._srcLoader:getFirstAssetItem() then
		slot0._mat.mainTexture = slot1:GetResource(slot0._iconUrl)

		gohelper.setActive(slot0._go, true)
		slot0:_openAnim(true)
	end
end

function slot0._getRandomIcon(slot0)
	if slot0._iconList[slot0:_getRandomIndex()] > 0 and lua_loading_icon.configDict[slot2] then
		return ResUrl.getLoadingBg(slot3.pic)
	end

	return "scenes/dynamic/v2a5_m_s01_zjm_a/lightmaps/dianshiji.png"
end

function slot0._getRandomIndex(slot0)
	if math.random(1, #slot0._iconList) ~= slot0._iconIndex then
		slot0._iconIndex = slot1

		return slot1
	end

	slot0._iconIndex = slot0._iconIndex + 1

	if slot0._iconIndex > #slot0._iconList then
		slot0._iconIndex = 1
	end

	return slot0._iconIndex
end

function slot0._onSceneClose(slot0)
	if slot0._srcLoader then
		slot0._srcLoader:dispose()

		slot0._srcLoader = nil
	end
end

return slot0
