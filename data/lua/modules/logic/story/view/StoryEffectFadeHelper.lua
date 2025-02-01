module("modules.logic.story.view.StoryEffectFadeHelper", package.seeall)

slot0 = class("StoryEffectFadeHelper")

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._initRenderAlphas = {}
	slot0._renderGos = {}

	for slot6 = 0, slot0._go.transform:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem)).Length - 1 do
		if not string.nilorempty(slot2[slot6].gameObject.name) then
			table.insert(slot0._renderGos, slot2[slot6].gameObject)
		end
	end

	for slot7 = 0, slot0._go.transform:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer)).Length - 1 do
		if not string.nilorempty(slot3[slot7].gameObject.name) then
			table.insert(slot0._renderGos, slot3[slot7].gameObject)
		end
	end

	for slot7, slot8 in ipairs(slot0._renderGos) do
		if slot8:GetComponent(typeof(UnityEngine.Renderer)) then
			for slot14 = 0, slot9.sharedMaterials.Length - 1 do
				if not gohelper.isNil(slot10[slot14]) and slot15:HasProperty("_MainColor") then
					slot16 = slot15:GetColor("_MainColor")
					slot0._initRenderAlphas[slot8.name .. "_" .. slot15.name] = {
						slot16.r,
						slot16.g,
						slot16.b,
						slot16.a
					}
				end
			end
		end
	end
end

function slot0.setTransparency(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._renderGos) do
		if slot6:GetComponent(typeof(UnityEngine.Renderer)) then
			for slot12 = 0, slot7.sharedMaterials.Length - 1 do
				if not gohelper.isNil(slot8[slot12]) and slot13:HasProperty("_MainColor") and slot0._initRenderAlphas[slot6.name .. "_" .. slot13.name] then
					slot14 = slot13:GetColor("_MainColor")
					slot14.a = slot1 * slot0._initRenderAlphas[slot6.name .. "_" .. slot13.name][4]

					slot13:SetColor("_MainColor", slot14)
				end
			end
		end
	end
end

function slot0.setEffectLoop(slot0, slot1)
	for slot6 = 0, slot0._go.transform:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem)).Length - 1 do
		slot2[slot6].main.loop = slot1
	end
end

function slot0.destroy(slot0)
	if not slot0._go or not slot0._go.transform then
		return
	end

	for slot4, slot5 in ipairs(slot0._renderGos) do
		if slot5:GetComponent(typeof(UnityEngine.Renderer)) then
			for slot11 = 0, slot6.sharedMaterials.Length - 1 do
				if not gohelper.isNil(slot7[slot11]) and slot12:HasProperty("_MainColor") and slot0._initRenderAlphas[slot5.name .. "_" .. slot12.name] then
					slot13 = slot12:GetColor("_MainColor")
					slot13.a = slot0._initRenderAlphas[slot5.name .. "_" .. slot12.name][4]

					slot12:SetColor("_MainColor", slot13)
				end
			end
		end
	end

	slot0._initRenderAlphas = nil
	slot0._renderGos = nil
end

return slot0
