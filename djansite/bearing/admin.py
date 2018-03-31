from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User

# Register your models here.
from bearing.models import Profile

# Define an inline admin descriptor for Employee model
# which acts a bit like a singleton
class AdminInline(admin.StackedInline):
    model = Profile
    can_delete = False
    verbose_name_plural = 'admin'

# Define a new User admin
class UserAdmin(UserAdmin):
    inlines = (AdminInline, )

# Re-register UserAdmin
admin.site.unregister(User)
admin.site.register(User, UserAdmin)