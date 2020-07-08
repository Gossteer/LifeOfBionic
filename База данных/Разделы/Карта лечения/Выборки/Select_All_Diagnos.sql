use Life_of_Bionic
go

create procedure Select_All_Diagnos
as
SELECT Diagnosis.id_Diagnoz,  dbo.DirectoryDisease.Name_Disease as 'Название болезни', 
dbo.Diagnosis.TimeDisease 'Период лечения (в днях)' , dbo.Medicament.Name_Medicament as 'Название лекарства', 
dbo.Diagnosis.Amount as 'Количество медикаментов' , dbo.TypeUse.Name_Use 'Применение' , dbo.TherapeuticDepartament.id_Room 'Номер палаты', 
                  dbo.CategoriesDisease.Name_CategoriesDisease
FROM     dbo.Diagnosis INNER JOIN
                  dbo.DirectoryDisease ON dbo.Diagnosis.id_Disease = dbo.DirectoryDisease.id_Disease INNER JOIN
                  dbo.Medicament ON dbo.Diagnosis.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
                  dbo.TherapeuticDepartament ON dbo.Diagnosis.ID_Room = dbo.TherapeuticDepartament.id_Room INNER JOIN
                  dbo.CategoriesDisease ON dbo.TherapeuticDepartament.id_CategoriesDisease = dbo.CategoriesDisease.id_CategoriesDisease INNER JOIN
                  dbo.TypeUse ON dbo.Diagnosis.id_TypeUse = dbo.TypeUse.id_TypeUse
WHERE dbo.Diagnosis.Diagnosis_Logical_Delete = 0