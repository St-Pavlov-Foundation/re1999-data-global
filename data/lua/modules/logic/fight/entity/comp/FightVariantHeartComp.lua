module("modules.logic.fight.entity.comp.FightVariantHeartComp", package.seeall)

slot0 = class("FightVariantHeartComp", LuaCompBase)
slot0.VariantKey = {
	"_STYLIZATIONMOSTER_ON",
	"_STYLIZATIONMOSTER2_ON",
	"_STYLIZATIONMOSTER3_ON",
	"_STYLIZATIONMOSTER2_ON",
	"_STYLE_JOINT_ON",
	"_STYLE_RAIN_STORM_ON",
	"_STYLE_ASSIST_ON",
	"_STYLIZATIONMOSTER4_ON"
}
slot1 = "_NoiseMap3"
slot2 = {
	"noise_01_manual",
	"noise_02_manual",
	"",
	"noise_03_manual",
	"noise_sty_joint2_manual",
	"textures/style_rain_strom_manual",
	"textures/style_assist_noise_manual",
	"textures/noise_05_manual"
}
slot3 = "_Pow"
slot4 = {
	{
		0.4,
		0.9,
		1.2,
		2.4
	},
	[3] = {
		0.08,
		0.09,
		0.1,
		0.1
	},
	[4] = {
		0,
		0,
		0,
		0
	},
	[5] = {
		0.4,
		0.9,
		1.2,
		2.4
	}
}
slot5 = "_StyOffset"
slot6 = {
	0,
	0,
	0,
	1,
	0
}
slot7 = {
	[8.0] = "roleeffects/roleeffect_glitch"
}

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._hostEntity = slot1
end

function slot0.setEntity(slot0, slot1)
	slot0._hostEntity = slot1

	slot0:_change()
end

function slot0.init(slot0, slot1)
	slot0.go = slot1

	FightController.instance:registerCallback(FightEvent.OnSpineMaterialChange, slot0._onMatChange, slot0, LuaEventSystem.Low)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
end

function slot0.removeEventListeners(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, slot0._onMatChange, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
end

function slot0._onMatChange(slot0, slot1, slot2)
	if slot1 == slot0.entity.id then
		slot0:_change()
	end
end

function slot0._onSpineLoaded(slot0, slot1)
	if slot1 == slot0.entity.spine then
		slot0:_change()
	end
end

function slot0._change(slot0)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	if not slot0._hostEntity or not slot0._hostEntity:getMO() then
		return
	end

	slot2 = slot0._hostEntity:getMO() and slot1:getCO()

	if not slot2 or not slot2.heartVariantId or not uv0.VariantKey[slot3] then
		return
	end

	if gohelper.isNil(slot0.entity.go) then
		return
	end

	slot0:_changeVariant(slot3)
end

function slot0._changeVariant(slot0, slot1)
	slot2 = uv0.VariantKey[slot1]
	slot3 = uv1[slot1]
	slot4 = uv2[slot1]
	slot6 = uv3[slot1] and uv3[slot1][FightHelper.getModelSize(slot0.entity)]

	if not slot0.entity.spineRenderer:getReplaceMat() then
		return
	end

	if slot2 then
		slot7:EnableKeyword(slot2)
	end

	if slot6 and slot7:HasProperty(uv4) then
		slot8 = slot7:GetVector(uv4)
		slot8.w = slot6

		slot7:SetVector(uv4, slot8)
	end

	if slot4 then
		slot7:SetFloat(uv5, slot4)
	end

	if not string.nilorempty(slot3) then
		slot0._texturePath = ResUrl.getRoleSpineMatTex(slot3)

		loadAbAsset(slot0._texturePath, false, slot0._onLoadCallback, slot0)
	end

	if not uv6[slot1] then
		slot0:clearLoader()
		slot0:clearEffect()

		slot0.curEffectRes = nil
	elseif not slot0.effectWrap or slot0.curEffectRes ~= slot8 then
		slot0.curEffectRes = slot8

		slot0:clearLoader()

		slot0.effectLoader = MultiAbLoader.New()

		slot0.effectLoader:addPath(FightHelper.getEffectAbPath(FightHelper.getEffectUrlWithLod(slot8)))
		slot0.effectLoader:startLoad(slot0.onEffectLoaded, slot0)
	end
end

function slot0.onEffectLoaded(slot0)
	slot0.effectWrap = slot0.entity.effect:addHangEffect(slot0.curEffectRes, ModuleEnum.SpineHangPointRoot)

	slot0.effectWrap:setLocalPos(0, 0, 0)
end

function slot0._onLoadCallback(slot0, slot1)
	if slot1.IsLoadSuccess then
		slot0._assetItem = slot1

		slot1:Retain()
		slot0.entity.spineRenderer:getReplaceMat():SetTexture(uv0, slot1:GetResource(slot0._texturePath))
	end
end

function slot0.clearEffect(slot0)
	if slot0.effectWrap then
		slot0.entity.effect:removeEffect(slot0.effectWrap)

		slot0.effectWrap = nil
	end
end

function slot0.clearLoader(slot0)
	if slot0.effectLoader then
		slot0.effectLoader:dispose()

		slot0.effectLoader = nil
	end
end

function slot0.onDestroy(slot0)
	slot0:clearLoader()
	slot0:clearEffect()

	slot0.curEffectRes = nil

	if slot0._assetItem then
		slot0._assetItem:Release()

		slot0._assetItem = nil
	end
end

return slot0
