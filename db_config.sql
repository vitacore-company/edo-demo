--start transaction; 

update "identity"."Users" u set "IsActive" = true; 
update org."Organizations" o set "State" = 2; 
insert into "identity"."UserRoles" ("UserId", "RoleId") select u."Id", (select r."Id" from "identity"."Roles" r where r."Name" = $$SuperAdmin$$ limit 1) from "identity"."Users" u; 

--rollback;