import os
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker

DATABASE_URL = os.getenv('DATABASE_URL', 'postgresql+asyncpg://utkrusht_admin:tenantpass2024@db:5432/tenant_db')
engine = create_async_engine(DATABASE_URL, echo=True)
async_session = sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)
