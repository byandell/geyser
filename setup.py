from setuptools import setup, find_packages

setup(
    name='geyser',
    version='0.2',
    packages=find_packages(),
    install_requires=[
        'matplotlib',
        'nest_asyncio',
        'numpy',
        'rpy2',
        'scipy',
        'shiny'
    ],
)
